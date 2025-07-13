# show git status
function gs {
        git status
}

# edit file searched by fzf
function nf {
        $selectedFile = fzf

        if ($selectedFile)
        {
                nvim $selectedFile
        }
}

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Install posh-git for git autocompletion
Import-Module posh-git

# Load prompt theme
oh-my-posh init pwsh --config ~/.dotfiles/oh-my-posh/custom.json | Invoke-Expression
