#!/bin/bash

echo "🚀 Initializing Viral Food Caption & Promo Generator..."

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📦 Initializing Git repository..."
    git init
    git add .
    git commit -m "Initial commit: Viral Food Caption & Promo Generator for Whop store"
    echo "✅ Git repository initialized and files committed."
else
    echo "ℹ️ Git repository already exists."
fi

echo ""
echo "🌐 Starting local development server..."
echo "Open your browser at: http://localhost:8000"
echo "Press Ctrl+C to stop the server."
echo ""

# Start python local web server
python3 -m http.server 8000
