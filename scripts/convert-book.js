const { execSync } = require('child_process');
const path = require('path');
const fs = require('fs');

const bookDir = path.join(__dirname, '..', 'book');

// Find first PDF in book directory
const files = fs.readdirSync(bookDir);
const pdfFile = files.find(file => file.toLowerCase().endsWith('.pdf'));

if (!pdfFile) {
    console.error(`Error: No PDF found in ${bookDir}`);
    process.exit(1);
}

const inputPdf = path.join(bookDir, pdfFile);
const outputMd = path.join(bookDir, pdfFile.replace(/\.pdf$/i, '.md'));

console.log(`Converting ${inputPdf} to ${outputMd}...`);

try {
    // using pdftotext with -layout to preserve some structure
    execSync(`pdftotext -layout "${inputPdf}" "${outputMd}"`, { stdio: 'inherit' });
    console.log('Conversion complete!');
} catch (error) {
    console.error('Conversion failed:', error);
    process.exit(1);
}
