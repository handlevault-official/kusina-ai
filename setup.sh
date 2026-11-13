#!/bin/bash

echo "🚀 Nagsisimula ang setup ng Viral Food Caption & Promo Generator..."

# 1. Gumawa at pumasok sa folder ng proyekto
mkdir -p viral-food-caption-generator
cd viral-food-caption-generator

echo "📁 Ginagawa ang mga kinakailangang file..."

# 2. Lumikha ng index.html
cat << 'EOF' > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Viral Food Caption & Promo AI</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-slate-950 text-slate-100 min-h-screen font-sans antialiased">
    <div class="max-w-4xl mx-auto px-4 py-10">
        <header class="text-center mb-10">
            <span class="bg-red-500/10 text-red-400 text-xs font-semibold px-3 py-1 rounded-full border border-red-500/20 uppercase tracking-wider">AI-Powered Food Marketing Suite</span>
            <h1 class="text-4xl sm:text-5xl font-extrabold mt-3 tracking-tight bg-gradient-to-r from-red-400 via-orange-400 to-amber-300 bg-clip-text text-transparent">
                Viral Food Caption & Promo Generator
            </h1>
            <p class="text-slate-400 mt-2 max-w-xl mx-auto text-sm sm:text-base">
                Gumawa ng nakakatakam na Taglish captions, TikTok hooks, at promo broadcasts sa loob lang ng ilang segundo. Palakasin ang benta ng pagkain mo ngayon!
            </p>
        </header>

        <main class="bg-slate-900 border border-slate-800 rounded-2xl p-6 sm:p-8 shadow-2xl">
            <form id="generatorForm" class="space-y-6">
                <div>
                    <label class="block text-xs font-medium text-slate-400 uppercase tracking-wider mb-1">Google Gemini API Key</label>
                    <input type="password" id="apiKey" required placeholder="Ilagay ang iyong Gemini API Key dito" class="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-3 text-sm text-slate-200 focus:outline-none focus:border-red-500 transition">
                    <p class="text-xs text-slate-500 mt-1">Kailangan ng Gemini API key para makapag-generate ng AI content.</p>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-xs font-medium text-slate-400 uppercase tracking-wider mb-1">Pangalan ng Pagkain / Dish *</label>
                        <input type="text" id="foodItem" required placeholder="Hal. Spicy Honey Glazed Wings, Ube Cheese Pandesal" class="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-3 text-sm text-slate-200 focus:outline-none focus:border-red-500 transition">
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-slate-400 uppercase tracking-wider mb-1">Presyo / Promo Details</label>
                        <input type="text" id="promoDetails" placeholder="Hal. ₱299 lang! Buy 1 Take 1 Free delivery" class="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-3 text-sm text-slate-200 focus:outline-none focus:border-red-500 transition">
                    </div>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-xs font-medium text-slate-400 uppercase tracking-wider mb-1">Target Platform</label>
                        <select id="platform" class="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-3 text-sm text-slate-200 focus:outline-none focus:border-red-500 transition">
                            <option value="Facebook / Instagram Post">Facebook / Instagram Post</option>
                            <option value="TikTok / Reels Short Hook">TikTok / Reels Short Hook</option>
                            <option value="Messenger / Viber Suki Broadcast">Messenger / Viber Suki Broadcast</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-slate-400 uppercase tracking-wider mb-1">Marketing Vibe / Tone</label>
                        <select id="vibe" class="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-3 text-sm text-slate-200 focus:outline-none focus:border-red-500 transition">
                            <option value="Cravings Mode (Nakakatakam)">Cravings Mode (Nakakatakam)</option>
                            <option value="Witty & Relatable">Witty & Relatable</option>
                            <option value="Urgent / FOMO (Limited Slots)">Urgent / FOMO (Limited Slots)</option>
                        </select>
                    </div>
                </div>

                <button type="submit" id="generateBtn" class="w-full bg-gradient-to-r from-red-600 to-orange-600 hover:from-red-500 hover:to-orange-500 text-white font-semibold py-3.5 px-6 rounded-lg shadow-lg transition duration-200 flex items-center justify-center space-x-2 cursor-pointer">
                    <i class="fa-solid fa-wand-magic-sparkles"></i>
                    <span>Generate Viral Captions Now</span>
                </button>
            </form>

            <div id="loading" class="hidden text-center py-12">
                <div class="inline-block animate-spin rounded-full h-10 w-10 border-4 border-red-500 border-t-transparent"></div>
                <p class="text-slate-400 text-sm mt-3">Gumagawa ng nakakatakam na captions ang AI...</p>
            </div>

            <div id="results" class="hidden mt-8 space-y-6 pt-6 border-t border-slate-800">
                <h2 class="text-lg font-bold text-slate-200 flex items-center gap-2">
                    <i class="fa-solid fa-fire text-orange-500"></i> Generated Results (3 Options)
                </h2>
                <div id="captionsContainer" class="space-y-4"></div>
            </div>
        </main>

        <footer class="text-center mt-10 text-xs text-slate-500">
            &copy; Viral Food Caption & Promo AI. Universal Store Ready (Whop / Gumroad).
        </footer>
    </div>

    <script src="script.js"></script>
</body>
</html>
EOF

# 3. Lumikha ng script.js
cat << 'EOF' > script.js
document.getElementById('generatorForm').addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const apiKey = document.getElementById('apiKey').value.trim();
    const foodItem = document.getElementById('foodItem').value.trim();
    const promoDetails = document.getElementById('promoDetails').value.trim();
    const platform = document.getElementById('platform').value;
    const vibe = document.getElementById('vibe').value;
    
    if (!apiKey) {
        alert('Please enter your Gemini API Key.');
        return;
    }

    const loadingEl = document.getElementById('loading');
    const resultsEl = document.getElementById('results');
    const containerEl = document.getElementById('captionsContainer');

    loadingEl.classList.remove('hidden');
    resultsEl.classList.add('hidden');
    containerEl.innerHTML = '';

    const prompt = `You are an expert food marketing copywriter in the Philippines. Generate exactly 3 distinct, high-converting Taglish social media captions for a food business.
    
Food Item: ${foodItem}
Price/Promo: ${promoDetails || 'Standard offering'}
Platform: ${platform}
Vibe/Tone: ${vibe}

Format the response as 3 clear options separated strictly by '---OPTION---'. Include relevant emojis, engaging hooks, clear Call-To-Action (CTA), and viral hashtags.`;

    try {
        const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=${apiKey}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                contents: [{ parts: [{ text: prompt }] }]
            })
        });

        const data = await response.json();
        
        if (data.error) {
            throw new Error(data.error.message || 'API Error');
        }

        const text = data.candidates[0].content.parts[0].text;
        const options = text.split('---OPTION---').filter(opt => opt.trim().length > 0);

        options.forEach((opt, index) => {
            const card = document.createElement('div');
            card.className = 'bg-slate-950 border border-slate-800 rounded-xl p-5 relative group';
            
            card.innerHTML = `
                <div class="flex justify-between items-center mb-3">
                    <span class="text-xs font-semibold text-red-400 uppercase tracking-wider">Option ${index + 1}</span>
                    <button onclick="copyCaption(this)" 
                        class="bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs px-3 py-1 rounded-md transition flex items-center gap-1.5 cursor-pointer">
                        <i class="fa-regular fa-copy"></i> Copy
                    </button>
                </div>
                <div class="caption-text text-slate-300 text-sm whitespace-pre-line leading-relaxed font-normal">${opt.trim()}</div>
            `;
            containerEl.appendChild(card);
        });

        resultsEl.classList.remove('hidden');
    } catch (error) {
        alert('Error generating captions: ' + error.message);
    } finally {
        loadingEl.classList.add('hidden');
    }
});

function copyCaption(button) {
    const textElement = button.parentElement.nextElementSibling;
    navigator.clipboard.writeText(textElement.innerText).then(() => {
        const originalHTML = button.innerHTML;
        button.innerHTML = '<i class="fa-solid fa-check text-green-400"></i> Copied!';
        setTimeout(() => {
            button.innerHTML = originalHTML;
        }, 2000);
    });
}
EOF

# 4. Lumikha ng README.md
cat << 'EOF' > README.md
# Viral-Food-Caption-Promo-Generator
AI-powered social media caption, TikTok hook, and promo generator for small food businesses, ready for your Whop store.
EOF

# 5. Lumikha ng .gitignore
cat << 'EOF' > .gitignore
node_modules/
.env
.env.local
.DS_Store
dist/
build/
*.log
EOF

# 6. Lumikha ng LICENSE
cat << 'EOF' > LICENSE
MIT License
Copyright (c) 2026 Viral Food Caption & Promo Generator
EOF

echo "📦 Initializing Git repository..."
if [ ! -d ".git" ]; then
    git init
    git add .
    git commit -m "Initial commit: Viral Food Caption & Promo Generator for Whop store"
    echo "✅ Git repository initialized successfully."
else
    echo "ℹ️ Git repository already exists."
fi

echo ""
echo "🌐 Starting local development server..."
echo "Open your browser at: http://localhost:8000"
echo "Pindutin ang Ctrl+C sa terminal kung gusto mong ihinto ang server."
echo ""

# Start python local web server
python3 -m http.server 8000
