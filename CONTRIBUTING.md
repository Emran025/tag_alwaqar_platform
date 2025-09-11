### **1. Project Structure**

The following structure is the definitive blueprint for our project's file organization. It is designed to be highly modular, scalable, and easy for any contributor to navigate. All files and directories must adhere to this structure to ensure consistency.

#### **3.1. General File and Folder Structure**

```
/tag_alwaqar_platform
│   .gitignore                  # Specifies files and folders to be excluded from Git version control.
│   CONTRIBUTING.md             # A guide for new contributors on how to set up the project and adhere to coding standards.
│   project-structure.ps1       # A PowerShell script to automate the creation of the project's standardized directory structure.
│   README.md                   # The primary project overview, detailing its purpose, technologies, and quick-start instructions.
│
├───assets                      # Contains all static assets, including CSS, JavaScript, and images.
│   ├───css                     # Houses all stylesheets.
│   │   │   main.scss           # The main Sass entry file where all other partials are imported.
│   │   │
│   │   ├───abstracts           # Stores Sass variables, mixins, and functions that don't output CSS directly.
│   │   ├───base                # Contains foundational styles like typography, reset rules, and general styles.
│   │   ├───components          # Styles for small, reusable UI components (e.g., buttons, forms, cards).
│   │   ├───layout              # Styles for the overall page structure and grid systems.
│   │   ├───pages               # Styles specific to individual pages.
│   │   ├───themes              # Styles for different visual themes (e.g., dark/light mode).
│   │   └───vendors             # Stores styles from external CSS libraries.
│   ├───images                  # All project image files.
│   │   ├───icons               # A dedicated folder for all SVG or PNG icon assets.
│   │   └───illustrations       # Stores illustrations and visual graphics.
│   └───js                      # Contains all JavaScript files.
│       │   main.js             # The primary JavaScript entry point for the application logic.
│       │   vendor.js           # For third-party JavaScript libraries.
│       │
│       ├───modules             # A collection of modular JavaScript files, each handling a specific feature.
│       │       about-us-and-policies.js # Handles logic for the "About Us" and "Policies" page.
│       │       achievements.js          # Manages logic for the achievements page.
│       │       school-blog-page.js      # Handles dynamic functionality for the blog page.
│       │       school-registration.js   # Contains validation logic for the school registration form.
│       │       student-registration.js  # Manages form validation for student registration.
│       │       teacher-registration.js  # Contains form validation for teacher registration.
│       │
│       └───utils               # Holds reusable utility functions and helpers.
├───docs                        # Project documentation.
│       srs-document.md         # The Software Requirements Specification document.
│
└───pages                       # Contains all HTML pages that form the website's structure.
        about-us-and-policies.html # The "About Us" and "Policies" content page.
        achievements.html            # The page showcasing project achievements.
        contact-us.html              # The contact form page.
        index.html                   # The homepage and main landing page.
        school-blog-page.html        # The school's blog page.
        school-registration.html     # The registration page for schools.
        student-registration.html    # The registration page for students.
        teacher-registration.html    # The registration page for teachers.
```

---

#### **1.2. File and Component Naming Guide**

To maintain clarity and consistency, all files, directories, and components must follow a strict naming convention.

- **Lowercase Only:** All file and directory names must be in lowercase.
- **Kebab-Case:** Use hyphens (`-`) to separate words in file names (e.g., `about-us.html`, `school-registration.js`).

**Examples:**

- `pages/contact-us.html` (Correct)
- `pages/ContactUs.html` (Incorrect)

**CSS/Sass Files:**

- Use a leading underscore (`_`) for Sass partials to prevent them from being compiled as separate CSS files (e.g., `_variables.scss`).

**JavaScript Files:**

- Name JavaScript modules based on their specific function (e.g., `school-registration.js` for validation logic).

---

### **2. Code Standards**

Adhering to a uniform set of coding standards is essential for a collaborative project. These guidelines ensure that our codebase is clean, consistent, and easy for any developer to read and understand.

#### **2.1. HTML Guidelines**

We use **semantic HTML5** to build a robust and accessible structure for our web pages. This means using elements for their intended purpose, not just their appearance.

- **HTML5 Doctype:** Every HTML file must start with `<!DOCTYPE html>`.
- **Semantic Elements:** Use elements like `<header>`, `<nav>`, `<main>`, `<section>`, `<article>`, and `<footer>` to define the structure of the page. Avoid using generic `<div>` tags when a more descriptive element is available.
- **Language and Direction:** The `<html>` tag must include `lang="ar"` and `dir="rtl"` to correctly define the language and text direction.
- **Indentation:** Use **2 spaces** for indentation. Avoid using tabs.
- **Self-Closing Tags:** Do not use a trailing slash for self-closing tags (e.g., `<img src="...">`, not `<img src="..." />`).
- **Attribute Quotes:** Use double quotes (`"`) for all attribute values.

#### **2.2. CSS/Sass Guidelines**

Our styling is powered by **Sass (SCSS)**, which is organized using the **7-1 Pattern** for ultimate scalability. We also adopt the **BEM (Block, Element, Modifier)** methodology for class naming to prevent style conflicts.

- **File Structure:** All Sass files must reside in the `assets/css` directory and its subfolders as specified in the project structure.
- **BEM Naming:** Use `block__element--modifier` for all component-specific class names. This makes the purpose and relationship of each class immediately clear.
  - **Example:** `.card__title` and `.btn--primary`.
- **Sass Variables:** Store all colors, fonts, and spacing values in `_variables.scss` within the `abstracts` directory. This promotes consistency and makes global style changes easy.
- **Nesting:** Avoid excessive nesting in Sass. Limit nesting to a maximum of 3 levels to maintain readability.
- **Indentation and Spacing:** Use **2 spaces** for indentation.

#### **2.3. JavaScript Guidelines**

We use **vanilla JavaScript** to maintain a lean, high-performance, and dependency-free front-end. Our JavaScript code should be modular and follow modern syntax.

- **Modularity:** All JavaScript functionality should be encapsulated within modules and placed in the `assets/js/modules` directory. Avoid writing a single, monolithic script.
- **Variable Declarations:** Use `const` for variables that do not change and `let` for variables that will be reassigned. Avoid using `var`.
- **Arrow Functions:** Prefer arrow functions (`=>`) for concise syntax, especially for callbacks.
- **DOM Access:** Cache DOM elements in variables to avoid repetitive queries.
  - **Good:** `const button = document.querySelector('.my-btn'); button.addEventListener(...)`
  - **Bad:** `document.querySelector('.my-btn').addEventListener(...)`
- **Comments:** Use comments to explain the "why" behind a piece of code, not just the "what." Explain complex logic or a function's purpose.

---

### **3. UI/UX Guidelines**

A successful interface is not just about functionality; it's about providing a seamless, intuitive, and visually appealing experience for all users. The following guidelines ensure our platform is both beautiful and highly usable.

#### **3.1. Responsive Design Principles**

Our platform adopts a **mobile-first approach**. This strategy ensures that our core content and functionality are prioritized on small screens before we progressively enhance the design for larger devices.

- **Fluid Units:** Use relative units like percentages (`%`), `rem`, and `em` for layouts and typography. Avoid fixed units like pixels (`px`) wherever possible to ensure components scale smoothly.
- **Flexible Grid:** The layout must be built using a flexible grid system, leveraging CSS Flexbox or Grid. This allows elements to fluidly reflow and adapt to different screen sizes.
- **Media Queries:** Use media queries to apply style adjustments at specific **breakpoints**. Breakpoints should be based on the content's needs, not on predefined device sizes. For example, if a navigation menu looks cluttered at 768px, that's where a breakpoint should be added to adjust its layout.
- **Responsive Images:** All images must be responsive. Use the CSS properties `max-width: 100%;` and `height: auto;` to prevent images from overflowing their containers. For performance, consider using the HTML `<picture>` element or the `srcset` attribute to serve different image sizes based on the user's viewport.

#### **3.2. Browser Compatibility**

We ensure our platform works correctly and consistently across the most popular web browsers. While modern browsers are the priority, the core experience must be functional on slightly older versions.

- **Baseline Support:** The project must function correctly on the two most recent major versions of the following browsers: **Google Chrome, Mozilla Firefox, Microsoft Edge, and Apple Safari**.
- **Progressive Enhancement:** Build upon a solid foundation of widely supported CSS and JavaScript features. Advanced or experimental features should be layered on top, so the core functionality remains accessible even if a browser doesn't support the latest technology.
- **Vendor Prefixes:** Utilize a build tool like **Autoprefixer** to automatically add vendor prefixes to CSS properties (e.g., `-webkit-`, `-moz-`). This prevents manual errors and ensures broad compatibility.
- **Testing:** Before pushing a new feature, a basic cross-browser check should be performed to catch any major rendering issues.

---

#### **3.3. Accessibility Guidelines (WCAG)**

Our goal is to create a web experience that is accessible to all users, including those with disabilities. Our guidelines are based on the **Web Content Accessibility Guidelines (WCAG) 2.1**, a globally recognized standard.

- **Semantic HTML:** We rely on semantic HTML to provide a meaningful structure that screen readers and other assistive technologies can interpret. For example, use `<nav>` for navigation menus and `<button>` for interactive buttons, not `<div>` tags.
- **Keyboard Navigation:** All interactive elements, such as links, buttons, and form fields, must be fully navigable and usable with a keyboard alone. Ensure that the focus indicator (`:focus`) is always clearly visible.
- **Color Contrast:** All text and critical UI elements must have a sufficient **color contrast ratio** against their background. This ensures readability for users with low vision. You can use online tools to check contrast ratios.
- **Alternative Text for Images:** All images that convey information must include descriptive `alt` text. This provides a textual alternative for screen readers and in cases where images fail to load. Decorative images can have an empty `alt=""` attribute.
- **Accessible Forms:** All form inputs must have a corresponding `<label>` tag linked via the `for` attribute. This allows screen readers to announce the purpose of each field. Error messages must be clearly associated with their respective input fields.

#### **3.4. Ideal User Experience (UX)**

Beyond the code, we strive to build a user experience that is intuitive, efficient, and enjoyable. Our UX principles focus on minimizing user friction and providing clear, actionable feedback.

- **Clarity and Simplicity:** The interface should be uncluttered and easy to understand. Every element, from a button to a text block, must have a clear purpose. Avoid unnecessary visual noise.
- **Instant Feedback:** Users should receive immediate feedback for their actions. This includes visual cues like button state changes on hover/click, as well as clear success or error messages for forms. This helps users understand the status of their actions and builds trust in the system.
- **Intuitive Navigation:** The site's navigation must be consistent and predictable across all pages. Users should be able to find their way around without a learning curve.
- **Error Prevention and Recovery:** Design forms to prevent errors where possible (e.g., using date pickers) and provide clear, friendly error messages when they do occur. Help users understand what went wrong and how to fix it.

---

#### **3.5. Color and Typography Style Guide**

A consistent visual identity is key to a professional and trustworthy brand. This style guide outlines the definitive color palette and typography rules to be used throughout the platform.

- **Color Palette:** We use a specific set of colors to maintain brand consistency. The color palette is categorized by function:
  - **Primary Colors:** Used for main branding elements, such as the logo and key calls-to-action (CTAs).
  - **Accent Colors:** Used to highlight important information, links, and interactive elements.
  - **System Colors:** A set of colors dedicated to specific system states, such as green for **success**, red for **errors**, and blue for **information**.
- **Typography:** Our fonts are chosen for optimal readability and a professional look.
  - **Main Font:** Used for all body text. It must be clear and readable at various sizes.
  - **Heading Font:** Used for titles (H1, H2, H3, etc.).
  - **Font Sizes:** We use a modular scale for font sizes to ensure harmony. All font sizes should be defined using `rem` units to support accessibility and responsive scaling.

---

### **4. Tools and Work Environment**

This section provides the essential tools and a step-by-step guide to set up a local development environment. Following these instructions will ensure a consistent and efficient workflow for all contributors.

#### **4.1. Recommended Development Tools**

To ensure a smooth and standardized development process, we recommend using the following tools:

- **Code Editor:** We highly recommend **Visual Studio Code (VS Code)**. It's a powerful and free code editor with a rich ecosystem of extensions that enhance front-end development.
- **Version Control:** **Git** is our version control system. All code contributions must be managed through Git.
- **Extensions for VS Code:**
  - **Prettier:** A code formatter that ensures a consistent coding style across the project.
  - **Live Sass Compiler:** Automatically compiles your Sass (`.scss`) files into CSS (`.css`) in real-time.
  - **Live Server:** Launches a local development server with live reload functionality, so you can see your changes instantly.

#### **4.2. Local Development Environment Setup**

Follow these steps to get your local environment ready for development:

1.  **Clone the Repository:** Open your terminal or Git Bash and clone the project to your local machine. This command will create the project's root directory.
    ```bash
    git clone [your-repository-url]
    ```
2.  **Run the Setup Script:** Navigate into the newly created project directory and execute the PowerShell script we created. This will automatically generate the entire file and folder structure.
    ```bash
    cd tag_alwaqar_platform
    .\project-structure.ps1
    ```
    You will see a confirmation message once the script has finished running successfully.
3.  **Install VS Code Extensions:** Open the project in VS Code. Go to the Extensions view (Ctrl+Shift+X) and install the recommended extensions mentioned above.
4.  **Start Development:** With the structure in place and your extensions installed, you are ready to begin coding. Use **Live Server** to view your changes in real time. Remember to create a new branch for each new feature or bug fix.
