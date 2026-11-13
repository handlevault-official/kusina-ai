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
 
