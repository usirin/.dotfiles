# vi: ft=sh
local new_line=$'\n'
local clr_shadow="%{$fg[magenta]%}"
local clr_blonde="%{$fg[yellow]%}"
local clr_grass="%{$FG[010]%}"

local prompt_pwd_color=$clr_blonde
local prompt_git_color="%{$FG[010]%}"
local prompt_prompt_color=$clr_blonde

if [ "$SSH_CONNECTION" ]; then
    prompt_prompt_color=$clr_shadow
fi

local prompt_git_dirty_color=$clr_blonde
local prompt_git_clean_color=$clr_grass

local prompt_git_dirty="✗"
local prompt_git_clean="✓"

local prompt_prompt="≫ "

# borrowed from:
# https://github.com/robbyrussell/oh-my-zsh/blob/b15918d414f255f8d2b36c99a338f930d7431b21/themes/fishy.zsh-theme#L3-L10
_fishy_collapsed_wd() {
    echo $(pwd | perl -pe '
   BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
   }; s|^$ENV{HOME}|~|g; s|/([^/.])[^/]*(?=/)|/$1|g; s|/\.([^/])[^/]*(?=/)|/.$1|g
    ')
}

local ret_git_dirty="${prompt_git_dirty_color}${prompt_git_dirty}"
local ret_git_clean="${prompt_git_clean_color}${prompt_git_clean}"
local ret_prompt="${prompt_prompt_color}${prompt_prompt}"

ZSH_THEME_GIT_PROMPT_PREFIX="$clr_blonde:%{$reset_color%}${prompt_git_color}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color%} ${ret_git_dirty}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%} ${ret_git_clean}%{$reset_color%}"

# local _usirin_prompt='${prompt_pwd_color}$(_fishy_collapsed_wd)$(git_prompt_info)% %{$reset_color%}${new_line}${ret_prompt}%{$reset_color%}'

# gitfree because big repos are big and slow
local _usirin_prompt='${prompt_pwd_color}$(_fishy_collapsed_wd) ${clr_shadow}~ ${clr_grass}$(git_current_branch) %{$reset_color%}${new_line}${ret_prompt}%{$reset_color%}'

if [ "$SSH_CONNECTION" ]; then
    _usirin_prompt="${prompt_prompt_color}$(hostname):${_usirin_prompt}"
fi

PROMPT=$_usirin_prompt
