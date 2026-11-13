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
