module VTKView
import Libdl
 
include("vtkfig_capi.jl")

include("vtkfig_static_frame.jl")


export interact
export display
export add!
export clear!
export remove!
export write_png
export write_vtk
export start_video
export stop_video
export size!
export layout!
export windowtitle!
export frametitle!
export position!

export rectilineargrid!
export simplexgrid!
export pointscalar!
export data!
export write_vtk

export isolevels!
export show_isosurfaces!

export title!
export show_legend!
export show_grid!
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
