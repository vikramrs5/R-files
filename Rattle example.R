system('brew install gtk+')

local({
  if (Sys.info()[['sysname']] != 'Darwin') return()
  
  .Platform$pkgType = 'mac.binary.el-capitan'
  unlockBinding('.Platform', baseenv())
  assign('.Platform', .Platform, 'package:base')
  lockBinding('.Platform', baseenv())
  
  options(
    pkgType = 'both', install.packages.compile.from.source = 'always',
    repos = 'https://macos.rbind.org'
  )
})

install.packages(c('RGtk2', 'cairoDevice', 'rattle'))
Yes


usr/bin/vikramraj -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"