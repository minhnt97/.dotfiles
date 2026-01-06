function prompt {
   $p = $executionContext.SessionState.Path.CurrentLocation
   $osc7 = ""
   if ($p.Provider.Name -eq "FileSystem") {
       $ansi_escape = [char]27
       $provider_path = $p.ProviderPath -Replace "\\", "/"
       $osc7 = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\"
   }
   "${osc7}PS $p$('>' * ($nestedPromptLevel + 1)) "
}

function gs {
        git status
}

$env:LG_CONFIG_FILE = "$HOME\.dotfiles\lazygit\.config\lazygit\config.yml,$env:LOCALAPPDATA\nvim-data\lazy\kanagawa-paper.nvim\extras\lazygit\kanagawa-paper-ink.yml"

function lg {
         lazygit
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
