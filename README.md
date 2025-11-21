# Tech Book Tutor

## How to use this repo
This is a **template**. Create a new repository based on it to start your learning journey.

**Using GitHub CLI:**
Clone this repo using GitHub CLI:

```bash
gh repo create my-learning-project --template cbehrend/tech-book-tutor --private
```

Clone the repo you just created:

```bash
gh repo clone my-learning-project
```

Navigate to the new repo:
```bash
cd my-learning-project
```

**Setup:**
1.  **Add Content**:
    *   Place your book PDF into a directory named `book/` within the repo you created.
    *   Place your sample code into a directory named `sample-code/` within the repo you created.
2.  **Commit**:
    ```bash
    git add .
    git commit -m "Initial setup"
    ```

## Philosophy: Architect & Experimenter
In the age of AI, the skill of "typing syntax from memory" is being replaced by **articulating intent** and **verifying behavior**. This repo is designed to teach you React through this modern lens.

**How it works:**
1.  **You are the Architect**: You tell the AI *what* to build based on the book's concepts (e.g., "We need a test that fails when...").
2.  **AI is the Builder**: The AI writes the boilerplate and syntax for you.
3.  **Joint Experimentation**: You run the code, and then the AI challenges you with "What If" scenarios (mutations) to break the code and deepen your understanding of *why* it works.

---

## AI Pair Programming

**Prerequisites:**
*   **IDE**: Use an AI-powered IDE like **Cursor**, **Antigravity**, **Windsurf**, or **Kirō**.
*   **Mode**: Use **Agent Mode** (or equivalent) to allow the AI to run terminal commands and edit files.
*   **Model**: Use a high-context model:
    *   **Gemini 3 Pro (High)** (Recommended)
    *   **Claude 4.5 Sonnet**
    *   **GPT-5 mini**

## Workflow Phases

### Phase 1: Setup (One-time)
**Goal:** Prepare your machine, workspace, and book content.

1.  **Prerequisite**: Ensure your book PDF is located in the `book/` directory, and any accompanying code files are in the `sample-code/` directory.
2.  **Prompt**:
    > "Please read `AI_SETUP_PROMPT.md` and help me get ready."
3.  **Result**: The AI will:
    *   Verify Node.js.
    *   **Convert the PDF to Markdown** (if needed).
    *   Create your personal workspace (e.g., `githubprofilename/`).
    *   Initialize it for Chapter 1.

### Phase 2: AI Pair Programming (Daily work)
**Goal:** Work through the book chapters with AI guidance.

1.  **Prompt**:
    > "Please read `AI_PROMPT.md` and guide me."
2.  **Result:** The AI will read your progress from `props.yml` and resume the session.