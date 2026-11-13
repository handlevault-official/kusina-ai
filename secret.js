import { GoogleGenAI } from "https://esm.run/@google/genai";

// ILAGAY DITO ANG IYONG GEMINI API KEY MULA SA GOOGLE AI STUDIO
// Palitan ang "AQAb8RN6KlYrbyIGdVfa6KvuwS9fE0E_X8nMNBELPCCiPP88bBQ" ng iyong totoong Gemini API key
const apiKey = "AQAb8RN6KlYrbyIGdVfa6KvuwS9fE0E_X8nMNBELPCCiPP88bBQ"; 

const ai = new GoogleGenAI({ apiKey: apiKey });

window.generateCaption = async function() {
    const foodItem = document.getElementById("foodItem").value.trim();
    const offerDetails = document.getElementById("offerDetails").value.trim();
    const platform = document.getElementById("platform").value;
    const vibe = document.getElementById("vibe").value;
    
    const genBtn = document.getElementById("genBtn");
    const resultArea = document.getElementById("resultArea");
    const responseBox = document.getElementById("response");

    if (!foodItem) {
        alert("⚠️ Pakilagay muna kung anong pagkain ang ibebenta mo.");
        return;
    }

    genBtn.disabled = true;
    genBtn.innerText = "🍳 Nagluluto ng captions...";
    resultArea.style.display = "block";
    responseBox.innerText = "Sandali lang, ginagawa na ang viral posts mo...";

    const prompt = `Ikaw ay isang top food marketing copywriter sa Pilipinas. Gumawa ng 3 high-converting social media captions para sa isang food business:
    - Pagkain/Produkto: ${foodItem}
    - Presyo/Promo Details: ${offerDetails || "Walang nabanggit (mag-suggest ng magandang hook)"}
    - Platform: ${platform}
    - Tone/Style: ${vibe}

    Panuntunan:
    1. Gumamit ng natural na Taglish na pang-masa at nakakatakam basahin.
    2. Magbigay ng 3 malinaw na options (OPTION 1: Short & Punchy, OPTION 2: Story/Cravings Style, OPTION 3: Promo/Urgent Style).
    3. Lagyan ng tamang emojis, malakas na Call-To-Action (hal. "Comment MINE", "DM to order"), at 5-8 relevant local hashtags sa dulo ng bawat option.`;

    try {
        const response = await ai.models.generateContent({
            model: 'gemini-2.5-flash',
            contents: prompt,
        });

        responseBox.innerText = response.text;
    } catch (error) {
        console.error(error);
        responseBox.innerText = "❌ Nagka-problema sa pagkonekta. Pakisuri kung tama ang iyong API Key sa secret.js at kung naka-allow ang domain mo sa Google AI Studio.";
    } finally {
        genBtn.disabled = false;
        genBtn.innerText = "✨ Gumawa ng 3 Viral Captions";
    }
};

window.copyText = function() {
    const text = document.getElementById("response").innerText;
    navigator.clipboard.writeText(text);
    const copyBtn = document.getElementById("copyBtn");
    copyBtn.innerText = "✅ Nakopya na sa clipboard!";
    setTimeout(() => { copyBtn.innerText = "📋 Kopyahin Lahat ng Captions"; }, 2000);
};
