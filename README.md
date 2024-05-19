# Enhanced Reading Mode for Emacs

**Enhanced Reading Mode** is an Emacs minor mode that enhances readability by highlighting the initial characters of each word in a customizable way. This mode is inspired by techniques to improve reading speed and comprehension.

## Screenshot
![Enhanced Reading Mode](https://github.com/kborling/enhanced-reading-mode/blob/main/assets/enhanced.png)

## Features

- Customizable number of characters to highlight.
- Customizable font weight for highlighted characters.
- Automatically updates highlights as you type.

## Installation
You can install enhanced-reading-mode using popular package managers such as Straight and Elpaca. Choose the method that suits your preference:

### Manual
1. **Download** the `enhanced-reading-mode.el` file and save it to a directory of your choice.
2. **Add the following lines** to your Emacs configuration file (`.emacs` or `init.el`):

```elisp
(add-to-list 'load-path "path/to/directory/containing/enhanced-reading-mode.el")
(require 'enhanced-reading-mode)
```

### Straight
```elisp
(straight-use-package
  '(enhanced-reading-mode :type git :host github :repo "kborling/enhanced-reading-mode"))
;; Using the use-package integration
(use-package enhanced-reading-mode
  :straight (enhanced-reading-mode :host github :repo "kborling/enhanced-reading-mode" :files ("*.el")))
```

### Elpaca
```elisp
(use-package enhanced-reading-mode
  :ensure (enhanced-reading-mode :host github :repo "kborling/enhanced-reading-mode" :files ("*.el")))
```

### Doom Emacs
```elisp
(package! enhanced-reading-mode
  :recipe (:host github :repo "kborling/enhanced-reading-mode"))
```

### Spacemacs
```elisp
(enhanced-reading-mode :location (recipe :fetcher github :repo "kborling/enhanced-reading-mode"))
```

## Customization

### Highlight Length

The number of characters to highlight at the start of each word can be customized using the `enhanced-reading-highlight-length` variable.

```elisp
(setq enhanced-reading-highlight-length 4)
```

### Font Weight

The font weight of the highlighted text can be customized using the `enhanced-reading-font-weight` variable. Available options are:

- `ultra-heavy`
- `heavy`
- `ultra-bold`
- `bold`
- `semi-bold`
- `medium`

For example:

```elisp
(setq enhanced-reading-font-weight 'ultra-bold)
```

## Example Configuration

Here is an example configuration for your `.emacs` or `init.el`:

```elisp
(add-to-list 'load-path "path/to/enhanced-reading-mode.el")
(require 'enhanced-reading-mode)

;; Customize the highlight length and font weight
(setq enhanced-reading-highlight-length 4)
(setq enhanced-reading-font-weight 'ultra-bold)

;; Enable Enhanced Reading Mode by default in text mode
(add-hook 'text-mode-hook 'enhanced-reading-mode)
```

## Usage

- **Toggle the mode**: `M-x enhanced-reading-mode`
- **Customize settings**: `M-x customize-group RET enhanced-reading`

## Contributions

Contributions, bug reports, and feature requests are welcome. Please feel free to submit a pull request or open an issue on the GitHub repository.

## License

This project is licensed under the MIT License.

---

Enjoy an enhanced reading experience with Emacs!

---
