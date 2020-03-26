# 终端显示样式的配置
function fish_prompt --description 'Write out the prompt'
    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    __fish_git_prompt >/dev/null 2>&1

    if git_is_repo
        if not set -q __git_cb
            set __git_cb (set_color blue)" ("(set_color brred)(git branch | grep \* | sed 's/* //') (set_color -o bryellow)(__fish_git_prompt_informative_status)(set_color blue)")"
        end
    end


    if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end
    printf '%s %s%s%s%s ' "$USER" "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb
end



# 终端提示语配置
function fish_greeting
end

# 判断是否是git仓库的工具函数
function git_is_repo --description 'Check if directory is a repository'
  test -d .git
  or command git rev-parse --git-dir >/dev/null ^/dev/null
end
