module VTKFig
import Libdl
 
include("vtkfig_capi.jl")

include("vtkfig_static_frame.jl")






set_rectilinear_grid(this::DataSet, X::Vector{Float64},Y::Vector{Float64})=ccall( ("vtkfigSetRectilinearGrid2D",libvtkfig), Cvoid,(Ptr{Cvoid},Ptr{Cdouble},Cint,Ptr{Cdouble},Cint), this.cobj,X, length(X),Y,length(Y))

set_rectilinear_grid(this::DataSet, X::Vector{Float64},Y::Vector{Float64},Z::Vector{Float64})=ccall( ("vtkfigSetRectilinearGrid3D",libvtkfig), Cvoid,(Ptr{Cvoid},Ptr{Cdouble},Cint,Ptr{Cdouble},Cint,Ptr{Cdouble},Cint), this.cobj,X,length(X),Y,length(Y),Z,length(Z))

set_point_scalar(this::DataSet, X::Vector{Float64},name)=ccall(("vtkfigSetPointScalar",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cdouble},Cint,Cstring), this.cobj,X, length(X),name)

write_vtk(this::DataSet,fname; ftype="A")=ccall( ("vtkfigWriteVTK",libvtkfig), Cvoid, (Ptr{Cvoid},Cstring,Cstring,), this.cobj,fname,ftype)

set_data(this::ScalarView, dataset::DataSet,name)=ccall(("vtkfigSetData",libvtkfig),Cvoid, (Ptr{Cvoid},Ptr{Cvoid},Cstring),this.cobj,dataset.cobj,name)

set_isolevels(this::ScalarView, V::Vector{Float64})=ccall(("vtkfigSetIsolevels",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cdouble},Cint), this.cobj,V, length(V))

show_isosurfaces(this::ScalarView,b::Bool)=ccall(("vtkfigShowIsosurfaces",libvtkfig), Cvoid,(Ptr{Cvoid},Cint), this.cobj,Int(b))

add_plot(this::XYPlot, X::Vector{Float64},Y::Vector{Float64})=ccall(("vtkfigAddPlot",libvtkfig), Cvoid,(Ptr{Cvoid},Ptr{Cdouble},Cint,Ptr{Cdouble},Cint), this.cobj,X, length(X),Y,length(Y))
    
set_title(this::XYPlot,title)=ccall(("vtkfigSetTitle",libvtkfig),Cvoid,(Ptr{Cvoid},Cstring), this.cobj,title); 

show_legend(this::XYPlot,b::Bool)=ccall(("vtkfigShowLegend",libvtkfig), Cvoid,(Ptr{Cvoid},Cint), this.cobj,Int(b))

show_grid(this::XYPlot,b::Bool)=ccall(("vtkfigShowGrid",libvtkfig),Cvoid,(Ptr{Cvoid},Cint), this.cobj,Int(b))

adjust_labels(this::XYPlot,b::Bool)=ccall(("vtkfigAdjustLabels",libvtkfig), Cvoid,(Ptr{Cvoid},Cint), this.cobj,Int(b))

set_legend_position(this::XYPlot,x,y)=ccall(("vtkfigSetLegendPosition",libvtkfig), Cvoid,(Ptr{Cvoid},Cdouble, Cdouble,),this.cobj,x,y)

set_legend_size(this::XYPlot,w,h)=ccall(("vtkfigSetLegendSize",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble, Cdouble,),this.cobj,w,h)

clear(this::XYPlot)=ccall(("vtkfigClear",libvtkfig),Cvoid,(Ptr{Cvoid},),this.cobj)

set_plot_linetype(this::XYPlot, ltype)=ccall(("vtkfigSetPlotLineType",libvtkfig),Cvoid,(Ptr{Cvoid},Cstring),this.cobj,ltype) 

set_plot_markertype(this::XYPlot,mtype)=ccall(("vtkfigSetPlotMarkerType",libvtkfig), Cvoid,(Ptr{Cvoid},Cstring), this.cobj,mtype) 

set_plot_color(this::XYPlot,r,g,b)=ccall(("vtkfigSetPlotColor",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble,Cdouble,Cdouble,),this.cobj,r,g,b) 

set_plot_legend(this::XYPlot, legend)=ccall(("vtkfigSetPlotLegend",libvtkfig),Cvoid,(Ptr{Cvoid},Cstring,),this.cobj,legend) 

set_grid_color(this::XYPlot,r,g,b)=ccall(("vtkfigSetGridColor",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble,Cdouble,Cdouble,), this.cobj,r,g,b) 

set_axes_color(this::XYPlot,r,g,b)=ccall(("vtkfigSetAxesColor",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble,Cdouble,Cdouble,), this.cobj,r,g,b) 

set_xtitle(this::XYPlot,title)=ccall(("vtkfigSetXTitle",libvtkfig),Cvoid,(Ptr{Cvoid},Cstring), this.cobj,title) 
  
set_ytitle(this::XYPlot,title)=ccall(("vtkfigSetYTitle",libvtkfig), Cvoid,(Ptr{Cvoid},Cstring), this.cobj,title) 

set_linewidth(this::XYPlot,w)=ccall(("vtkfigSetLineWidth",libvtkfig), Cvoid,(Ptr{Cvoid},Cdouble,),this.cobj,w)

set_markersize(this::XYPlot,s)=ccall(("vtkfigSetMarkerSize",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble,),this.cobj,s)

set_xrange(this::XYPlot, x0,x1)=ccall(("vtkfigSetXRange",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble, Cdouble), this.cobj,x0,x1) 

set_yrange(this::XYPlot, y0,y1)=ccall(("vtkfigSetYRange",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble, Cdouble), this.cobj,y0,y1) 

set_number_of_xlabels(this::XYPlot,n)=ccall(("vtkfigSetNumberOfXLabels",libvtkfig), Cvoid,(Ptr{Cvoid},Cint,),this.cobj,n)

set_number_of_ylabels(this::XYPlot,n)=ccall(("vtkfigSetNumberOfYLabels",libvtkfig),Cvoid,(Ptr{Cvoid},Cint,), this.cobj,n)



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
