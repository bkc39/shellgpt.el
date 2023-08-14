# shellgpt.el

A ChatGPT client for Emacs based on [shell-gpt](https://pypi.org/project/shell-gpt/).

## Installation

First you need to install `shell-gpt`.

```
$ pip install shell-gpt
```

## [use-package](https://github.com/jwiegley/use-package)

Clone the repository

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

## Usage

You need to set the environment variable `OPENAI_API_KEY`

```
$ echo 'export OPENAI_API_KEY=<YOUR-API-KEY>' >> ~/.zshrc # or your shell init file
```

Alternatively, if if `OPENAI_API_KEY` is not defined then it will
search for `shellgpt:openai-config-file`, which should contain your
api key as its contents. The default is `~/.openai` but you can
customize this in your init:

```emacs-lisp
(use-package shellgpt
  ...
  :custom
  (shellgpt:openai-config-file PATH))
```

Send a query with "M-x shellgpt:quick-ask", or if you use the
bindings in the configs above, "C-c q".
