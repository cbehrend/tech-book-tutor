const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

try {
    // 1. Get Git Username
    let gitName;
    try {
        gitName = execSync('git config user.name').toString().trim();
    } catch (e) {
        console.warn('Could not get git user.name, defaulting to "student"');
        gitName = 'student';
    }

    // Sanitize name for directory use (remove spaces, special chars)
    const workspaceDir = gitName.replace(/[^a-zA-Z0-9-_]/g, '-').toLowerCase();
    const workspacePath = path.join(__dirname, '..', workspaceDir);

    // 2. Create Directory
    if (!fs.existsSync(workspacePath)) {
        fs.mkdirSync(workspacePath);
        console.log(`Created workspace directory: ${workspaceDir}/`);
    } else {
        console.log(`Workspace directory already exists: ${workspaceDir}/`);
    }

    // 3. Check & Convert Book
    console.log('\nChecking for book...');
    const bookDir = path.join(__dirname, '..', 'book');

    // Run conversion if needed
    const convertScript = path.join(__dirname, 'convert-book.js');
    try {
        execSync(`node "${convertScript}"`, { stdio: 'inherit' });
    } catch (e) {
        console.warn('\nWARNING: Book conversion failed or no PDF found.');
        console.warn('Please ensure a PDF exists in the "book/" directory.');
    }

    // Find the resulting Markdown file
    const files = fs.readdirSync(bookDir);
    const bookFile = files.find(file => file.toLowerCase().endsWith('.md'));

    if (!bookFile) {
        console.error('Error: No Markdown book file found after conversion attempt.');
        process.exit(1);
    }
    console.log(`Using book file: ${bookFile}`);

    // 4. Create props.yml
    const propsContent = `workspace: ${workspaceDir}
book_file: "${bookFile}"
current_chapter: 1
last_step: "setup"
`;
    const propsPath = path.join(__dirname, '..', 'props.yml');
    fs.writeFileSync(propsPath, propsContent);
    console.log(`Created props.yml with workspace: ${workspaceDir}`);

    console.log('\nSetup Complete!');
    console.log('-----------------------------------');
    console.log(`Your workspace is: ${workspaceDir}/`);
    console.log('Please proceed to Phase 2 in the README.');

} catch (error) {
    console.error('Setup failed:', error);
    process.exit(1);
}
