#!/bin/bash

echo "🚀 Nagsisimula ang setup ng Kusina AI - Viral Food Caption & Promo Generator..."

# 1. Gumawa at pumasok sa folder ng proyekto
mkdir -p kusina-ai
cd kusina-ai

echo "📁 Ginagawa ang All-in-One index.html at mga kinakailangang file..."

# 2. Lumikha ng All-in-One index.html (HTML + CSS + JS)
cat << 'EOF' > index.html
<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kusina AI - Viral Food Caption & Promo Generator</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-slate-950 text-slate-100 min-h-screen font-sans antialiased flex flex-col justify-between p-4 sm:p-6">
    <div class="max-w-4xl mx-auto w-full py-6">
        <header class="text-center mb-10">
            <span class="bg-red-500/10 text-red-400 text-xs font-semibold px-3 py-1 rounded-full border border-red-500/20 uppercase tracking-wider">AI-Powered Food Marketing Suite</span>
            <h1 class="text-3xl sm:text-5xl font-extrabold mt-3 tracking-tight bg-gradient-to-r from-red-400 via-orange-400 to-amber-300 bg-clip-text text-transparent">
                Kusina AI - Viral Food Caption Generator
            </h1>
            <p class="text-slate-400 mt-2 max-w-xl mx-auto text-sm sm:text-base">
                Gumawa ng nakakatakam na Taglish captions, TikTok hooks, at promo broadcasts sa loob lang ng ilang segundo.
            </p>
            <div class="mt-4">
                <a href="https://vaultkeeper117.gumroad.com/l/ztzxpg" target="_blank" rel="noopener noreferrer" class="inline-block bg-pink-600 hover:bg-pink-500 text-white text-xs font-semibold py-2 px-4 rounded-xl transition shadow-lg">
                    🛒 Get Full Access on Gumroad ($5-$6)
                </a>
            </div>
        </header>

        <main class="bg-slate-900 border border-slate-800 rounded-2xl p-6 sm:p-8 shadow-2xl">
            <form id="generatorForm" class="space-y-6">
                <div>
                    <label class="block text-xs font-medium text-slate-400 uppercase tracking-wider mb-1">Google Gemini API Key *</label>
                    <input type="password" id="apiKey" required placeholder="Ilagay ang iyong Gemini API Key dito" class="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-3 text-sm text-slate-200 focus:outline-none focus:border-red-500 transition">
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-xs font-medium text-slate-400 uppercase tracking-wider mb-1">Pangalan ng Pagkain / Dish *</label>
                        <input type="text" id="foodItem" required placeholder="Hal. Spicy Honey Glazed Wings" class="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-3 text-sm text-slate-200 focus:outline-none focus:border-red-500 transition">
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-slate-400 uppercase tracking-wider mb-1">Presyo / Promo Details</label>
                        <input type="text" id="promoDetails" placeholder="Hal. ₱299 lang! Buy 1 Take 1" class="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-3 text-sm text-slate-200 focus:outline-none focus:border-red-500 transition">
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
    </div>

    <footer class="text-center py-6 text-xs text-slate-500 border-t border-slate-900 mt-10">
        &copy; 2026 Kusina AI. HandleVault Official Ecosystem.
    </footer>

    <script>
        document.getElementById('generatorForm').addEventListener('submit', async function (e) {
            e.preventDefault();

            const apiKey = document.getElementById('apiKey').value.trim();
            const foodItem = document.getElementById('foodItem').value.trim();
            const promoDetails = document.getElementById('promoDetails').value.trim();
            const platform = document.getElementById('platform').value;
            const vibe = document.getElementById('vibe').value;

            const loading = document.getElementById('loading');
            const results = document.getElementById('results');
            const container = document.getElementById('captionsContainer');
            const btn = document.getElementById('generateBtn');

            loading.classList.remove('hidden');
            results.classList.add('hidden');
            container.innerHTML = '';
            btn.disabled = true;

            const prompt = `Ikaw ay isang viral Filipino food marketing copywriter. Gumawa ng eksaktong 3 magkakaibang high-converting Taglish captions para sa:
- Pagkain: ${foodItem}
- Promo/Presyo: ${promoDetails || 'Wala'}
- Platform: ${platform}
- Vibe/Tone: ${vibe}

Lagyan ng nakakatakam na description, emojis, malinaw na Call-to-Action (CTA), at relevant hashtags. Paghiwalayin ang 3 options gamit ang eksaktong separator na "---OPTION---" (walang iba pang intro o outro text).`;

            try {
                const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=${encodeURIComponent(apiKey)}`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        contents: [{ parts: [{ text: prompt }] }]
                    })
                });

                const data = await response.json();

                if (!response.ok) {
                    throw new Error(data.error?.message || 'Hindi gumana ang API key o may error sa request.');
                }

                const rawText = data.candidates?.[0]?.content?.parts?.[0]?.text || '';
                const options = rawText.split('---OPTION---').map(opt => opt.trim()).filter(Boolean);

                options.forEach((caption, index) => {
                    const card = document.createElement('div');
                    card.className = 'bg-slate-950 border border-slate-800 rounded-xl p-5 relative group';
                    card.innerHTML = `
                        <div class="flex justify-between items-center mb-3">
                            <span class="text-xs font-bold uppercase tracking-wider text-orange-400">Option ${index + 1}</span>
                            <button type="button" class="copy-btn bg-slate-800 hover:bg-slate-700 text-slate-200 text-xs px-3 py-1.5 rounded-lg transition flex items-center gap-1.5 cursor-pointer">
                                <i class="fa-regular fa-copy"></i> Copy
                            </button>
                        </div>
                        <p class="text-sm text-slate-300 whitespace-pre-line leading-relaxed"></p>
                    `;
                    card.querySelector('p').textContent = caption;
                    card.querySelector('.copy-btn').addEventListener('click', function () {
                        navigator.clipboard.writeText(caption);
                        this.innerHTML = '<i class="fa-solid fa-check text-emerald-400"></i> Copied!';
                        setTimeout(() => {
                            this.innerHTML = '<i class="fa-regular fa-copy"></i> Copy';
                        }, 2000);
                    });
                    container.appendChild(card);
                });

                results.classList.remove('hidden');
            } catch (err) {
                alert('Error: ' + err.message);
            } finally {
                loading.classList.add('hidden');
                btn.disabled = false;
            }
        });
    </script>
</body>
</html>
EOF

# 3. Lumikha ng README.md
cat << 'EOF' > README.md
# 🍔 Kusina AI - Viral Food Caption & Promo Generator

An AI-powered web application designed for Filipino food business owners, online sellers, and food parks to generate high-converting Taglish captions, TikTok hooks, and promotional broadcasts in seconds using Google Gemini AI.

🌐 **Live App:** [https://handlevault-official.github.io/kusina-ai/](https://handlevault-official.github.io/kusina-ai/)

---

## ✨ Features
- **AI-Powered Copywriting:** Generates 3 distinct viral marketing options tailored to your dish.
- **Customizable Vibes:** Switch between *Cravings Mode*, *Witty & Relatable*, or *Urgent / FOMO*.
- **Platform Optimized:** Built for Facebook/Instagram posts, TikTok/Reels hooks, and Messenger/Viber broadcasts.
- **One-Click Copy:** Easily copy generated captions directly to your clipboard.

## 🚀 Tech Stack
- **Frontend:** HTML5, Tailwind CSS (via CDN)
- **Icons:** FontAwesome
- **AI Integration:** Google Gemini API (`gemini-2.5-flash`)
- **Hosting:** GitHub Pages

## 🛠️ How to Use
1. Visit the live app: [https://handlevault-official.github.io/kusina-ai/](https://handlevault-official.github.io/kusina-ai/)
2. Enter your **Google Gemini API Key**.
3. Type your food item name, price or promo details, target platform, and marketing vibe.
4. Click **Generate Viral Captions Now** and copy your favorite result!

## 🛒 Get Full Access & More Tools
- Check out our full creator ecosystem and ready-to-use digital tools on our [Gumroad Store](https://vaultkeeper117.gumroad.com/l/ztzxpg).

---
*Built with ❤️ for indie creators and food entrepreneurs.*
EOF

# 4. Lumikha ng .gitignore
cat << 'EOF' > .gitignore
node_modules/
.env
.env.local
.DS_Store
dist/
build/
*.log
EOF

# 5. Lumikha ng LICENSE
cat << 'EOF' > LICENSE
MIT License
Copyright (c) 2026 Kusina AI - HandleVault Official
EOF

echo "📦 Initializing Git repository..."
if [ ! -d ".git" ]; then
    git init
    git branch -M main
    git add .
    git commit -m "Initial commit: Kusina AI - Viral Food Caption & Promo Generator"
    echo "✅ Git repository initialized successfully."
else
    echo "ℹ️ Git repository already exists."
fi

echo ""
echo "🌐 Starting local development server..."
echo "Open your browser at: http://localhost:8000"
echo "Pindutin ang Ctrl+C sa terminal kung gusto mong ihinto ang server."
echo ""

python3 -m http.server 8000
