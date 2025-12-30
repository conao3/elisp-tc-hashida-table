# tc-hashida-table.el

An Emacs package for visualizing Hashida-table keyboard layouts for Japanese T-Code input.

## Overview

tc-hashida-table generates SVG diagrams that display the key sequences used in T-Code Japanese input. The Hashida-table is a visual reference showing which two-key combinations produce specific Hiragana characters.

## Features

- Generates clear SVG keyboard layout visualizations
- Displays Hiragana character mappings with their corresponding key sequences
- Uses filled and outlined circles to indicate first and second keystrokes
- Renders directly in Emacs buffers with SVG support

## Installation

Clone this repository and add it to your load path:

```elisp
(add-to-list 'load-path "/path/to/elisp-tc-hashida-table")
(require 'tc-hashida-table)
```

## Usage

To display the Hiragana reference table:

```
M-x tc-hashida-table-hiragana
```

This opens a buffer showing all basic Hiragana characters alongside their keyboard sequence visualizations. Each row displays:
- The Hiragana character
- SVG diagrams showing which keys to press (black circle = first key, outlined circle = second key)

## Requirements

- Emacs with SVG support (typically Emacs 25+)

## License

GPL-3.0-or-later. See [LICENSE](LICENSE) for details.

## Author

Naoya Yamashita (conao3@gmail.com)
