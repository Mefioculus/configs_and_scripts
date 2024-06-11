# Defined in - @ line 1
function ls --wraps='ls -lh --color=auto' --wraps='exa -lh' --wraps='exa -lh --icons' --description 'alias ls=exa -lh --icons'
  exa -lh --icons $argv;
end
