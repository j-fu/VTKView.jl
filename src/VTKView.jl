module VTKView
import Libdl
using DocStringExtensions

include("vtkfig.jl")
include("wrappers.jl")


export interact
export display
export addview!
export clear!
export remove!
export writepng
export writevtk
export startvideo
export stopvideo
export size!
export layout!
export windowtitle!
export frametitle!
export position!

export rectilineargrid!
export simplexgrid!
export addpointscalar!
export data!
export write_vtk

export isolevels!
export show_isosurfaces!

export title!
export show_legend!
export show_grid!
export addplot!
export adjust_labels!
export legendposition!
export legendsize!
export plotlinetype!
export plotmarkertype!
export plotcolor!
export plotlegend!
export gridcolor!
export axescolor!
export xtitle!
export ytitle!
export linewidth!
export markersize!
export xrange!
export yrange!
export numberofxlabels!
export numberofylabels!

end
