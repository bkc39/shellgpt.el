# shellgpt.el

A ChatGPT client for Emacs based on [shell-gpt](https://pypi.org/project/shell-gpt/).

## Installation

First you need to install `shell-gpt`.

```
$ pip install shell-gpt
```

## [use-package](https://github.com/jwiegley/use-package)

First, clone the repository

```
$ git clone git@github.com:bkc39/shellgpt.el.git <path-to-shellgpt.el>
```

Then in your init file add:

```emacs-lisp
(use-package shellgpt
  :load-path "<path-to-shellgpt.el>"
  :bind ("C-c q" . shellgpt:quick-ask))
```

## [straight.el](https://github.com/radian-software/straight.el)

In your Emacs init file put in the following incantantion:

```emacs-lisp
(use-package shellgpt
  :straight (:host github
             :repo "bkc39/shellgpt.el"
             :files ("dist" "*.el"))
  :bind ("C-c q" . shellgpt:quick-ask))
```
