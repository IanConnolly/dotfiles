rtags() {
    ctags --languages=ruby,html,javascript . `bundle show --paths`
}
