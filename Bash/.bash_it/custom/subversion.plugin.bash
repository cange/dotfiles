svndiff(){
  svn diff "${@}" | colordiff
}