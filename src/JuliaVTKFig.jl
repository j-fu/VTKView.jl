module JuliaVTKFig
import Libdl
 
include("vtkfig_capi.jl")

include("vtkfig_static_frame.jl")



export add_figure
export remove_figure
export write_png
export write_vtk
export start_video
export stop_video
export set_size
export set_layout
export set_window_title
export set_frame_title
export set_position

export set_rectilinear_grid
export set_simplex_grid
export set_point_scalar
export set_data
export write_vtk

export set_isolevels
export show_isosurfaces

export add_plot
export set_title
export show_legend
export show_grid
export adjust_labels
export set_legend_position
export set_legend_size
export clear
export set_plot_linetype
export set_plot_markertype
export set_plot_color
export set_plot_legend
export set_grid_color
export set_axes_color
export set_xtitle
export set_ytitle
export set_linewidth
export set_markersize
export set_xrange
export set_yrange
export set_number_of_xlabels
export set_number_of_ylabels

end
