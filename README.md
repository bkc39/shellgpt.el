# shellgpt.el

A ChatGPT client for emacs based on [shell-gpt](https://pypi.org/project/shell-gpt/).

## Installation

First you need to install `shell-gpt`.

```
$ pip install shell-gpt
```

In your Emacs init file put t

```emacs-lisp
(use-package shellgpt
  :straight (:host github
             :repo "bkc39/shellgpt.el"
             :files ("dist" "*.el"))
  :bind ("C-c q" . shellgpt:quick-ask))
```
