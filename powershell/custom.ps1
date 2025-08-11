function gs {
        git status
}

function nf {
        $selectedFile = $(fzf --preview="bat {}")

        if ($selectedFile)
        {
                nvim $selectedFile
        }
}

function ff {
         fzf --preview="bat {}"
}

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Use PSCompletions
Import-Module PSCompletions

# Install posh-git for git autocompletion
Import-Module posh-git

# Load prompt theme
oh-my-posh init pwsh --config ~/.dotfiles/oh-my-posh/custom.json | Invoke-Expression
