document.getElementById('generatorForm').addEventListener('submit', async function(e) {
    e.preventDefault();

    const apiKey = document.getElementById('apiKey').value.trim();
    const foodItem = document.getElementById('foodItem').value.trim();
    const promoDetails = document.getElementById('promoDetails').value.trim();
    const platform = document.getElementById('platform').value;
    const vibe = document.getElementById('vibe').value;

    const loadingEl = document.getElementById('loading');
    const resultsEl = document.getElementById('results');
    const containerEl = document.getElementById('captionsContainer');

    loadingEl.classList.remove('hidden');
    resultsEl.classList.add('hidden');
    containerEl.innerHTML = '';

    const prompt = `Act as an expert food marketer in the Philippines. Generate 3 viral ${platform} captions in Taglish for a food business item: "${foodItem}" with promo details: "${promoDetails}". Tone/Vibe: ${vibe}. Make it engaging, mouth-watering, include emojis and relevant hashtags. Format output clearly with option numbers.`;

    try {
        const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${apiKey}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                contents: [{
                    parts: [{ text: prompt }]
                }]
            })
        });

        const data = await response.json();
        loadingEl.classList.add('hidden');

        if (data.candidates && data.candidates[0].content) {
            const rawText = data.candidates[0].content.parts[0].text;
            
            resultsEl.classList.remove('hidden');
            containerEl.innerHTML = `
                <div class="bg-slate-950 border border-slate-800 rounded-xl p-4 text-sm text-slate-300 whitespace-pre-line leading-relaxed">
                    ${rawText}
                </div>
            `;
        } else {
            alert('May error sa pag-generate. Siguraduhing tama ang iyong Gemini API Key.');
        }
    } catch (error) {
        loadingEl.classList.add('hidden');
        alert('Connection error. Pakisubukan muli.');
        console.error(error);
    }
});
