###########################################################################


const errorstring=
"""
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1

Package VTKView: Unable to open libvtkfig.so.

Please ensure  to have  compiled the  vtkfig package  and to  have the
environment variable LIBVTKFIG pointing to the library libvtkfig.so .

For detailed compilation instructions, see  https://github.com/j-fu/vtkfig .

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
"""


function __init__()
    if VERSION >= v"1.1" 
        lib=something(Libdl.dlopen(libvtkfig,Libdl.RTLD_NOW, throw_error=false), C_NULL)
    else
        lib=something(Libdl.dlopen_e(libvtkfig,Libdl.RTLD_NOW),C_NULL)
    end        
    if lib==C_NULL
        println(errorstring)
        # throw(LoadError("",0,""))
    end
end

###########################################################################
function print_openglinfo()
    ccall(("vtkfigPrintOpenGLInfo",libvtkfig),Cvoid, ())
end

export print_openglinfo


###########################################################################
mutable struct Frame
    cobj::Ptr
    Frame()= Frame(new())
end

"""
$(TYPEDSIGNATURES)
Create Frame (corresponds to desktop window).
"""
function Frame(this::Frame)
    this.cobj=ccall( ("vtkfigCreateFrame",libvtkfig), Ptr{Cvoid}, ())
    finalizer(destruct!,this)
    return this
end

destruct!(this::Frame)=ccall( ("vtkfigDestroyFrame",libvtkfig), Cvoid, (Ptr{Cvoid},),this.cobj)


###########################################################################
mutable struct DataSet
    cobj::Ptr
    DataSet()= DataSet(new())
end

"""
$(TYPEDSIGNATURES)
Create a data set.
"""
function DataSet(this::DataSet)
    this.cobj=ccall( ("vtkfigCreateDataSet",libvtkfig), Ptr{Cvoid}, ())
    finalizer(destruct!,this)
    return this
end

destruct!(this::DataSet)=ccall( ("vtkfigDestroyDataSet",libvtkfig), Cvoid, (Ptr{Cvoid},),this.cobj)


###########################################################################
mutable struct ScalarView
    cobj::Ptr
    ScalarView()= ScalarView(new())
end

"""
$(TYPEDSIGNATURES)
Create a view for showing 2D or 3D scalar data.
"""
function ScalarView(this::ScalarView)
    this.cobj=ccall( ("vtkfigCreateScalarView",libvtkfig), Ptr{Cvoid}, ())
    finalizer(destruct!,this)
    return this
end
destruct!(this::ScalarView)=ccall( ("vtkfigDestroyScalarView",libvtkfig), Cvoid, (Ptr{Cvoid},),this.cobj)


###########################################################################
mutable struct GridView
    cobj::Ptr
    GridView()= GridView(new())
end

"""
$(TYPEDSIGNATURES)
Create a view for showing 2D or 3D grids.
"""
function GridView(this::GridView)
    this.cobj=ccall( ("vtkfigCreateGridView",libvtkfig), Ptr{Cvoid}, ())
    finalizer(destruct!,this)
    return this
end
destruct!(this::GridView)=ccall( ("vtkfigDestroyGridView",libvtkfig), Cvoid, (Ptr{Cvoid},),this.cobj)

###########################################################################
mutable struct VectorView
    cobj::Ptr
    VectorView()= VectorView(new())
end

"""
$(TYPEDSIGNATURES)
Create a view for showing 2D or 3D vector data.
"""
function VectorView(this::VectorView)
    this.cobj=ccall( ("vtkfigCreateVectorView",libvtkfig), Ptr{Cvoid}, ())
    finalizer(destruct!,this)
    return this
end
destruct!(this::VectorView)=ccall( ("vtkfigDestroyVectorView",libvtkfig), Cvoid, (Ptr{Cvoid},),this.cobj)


###########################################################################
mutable struct XYPlot
    cobj::Ptr
    XYPlot()= XYPlot(new())
end

"""
$(TYPEDSIGNATURES)
Create a view for showing X-Y plots.
"""
function XYPlot(this::XYPlot)
    this.cobj=ccall( ("vtkfigCreateXYPlot",libvtkfig), Ptr{Cvoid}, ())
    finalizer(destruct!,this)
    return this
end

destruct!(this::XYPlot)=ccall( ("vtkfigDestroyXYPlot",libvtkfig), Cvoid, (Ptr{Cvoid},),this.cobj)



###########################################################################
# FRAME API

"""
$(TYPEDSIGNATURES)
Display frame content and enter interaction mode.
"""
interact(frame::Frame)=ccall(("vtkfigInteract",libvtkfig),Cvoid,(Ptr{Cvoid},),frame.cobj)

"""
$(TYPEDSIGNATURES)
Display frame content and continue.
"""
Base.display(frame::Frame)=ccall(("vtkfigShow",libvtkfig),Cvoid,(Ptr{Cvoid},),frame.cobj)

"""
$(TYPEDSIGNATURES)
Clear frame content.
"""
clear!(frame::Frame)=ccall(("vtkfigClearFrame",libvtkfig),Cvoid,(Ptr{Cvoid},),frame.cobj)

"""
$(TYPEDSIGNATURES)
Add view to frame.
"""
addview!(frame::Frame, scalarview::ScalarView)=ccall(("vtkfigAddScalarView",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),frame.cobj,scalarview.cobj)

"""
$(TYPEDSIGNATURES)
Add view to frame.
"""
addview!(frame::Frame, scalarview::ScalarView, pos::Int)=ccall(("vtkfigAddScalarViewAt",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}, Cint,), frame.cobj,scalarview.cobj,pos-1)

"""
$(TYPEDSIGNATURES)
Add view to frame.
"""
addview!(frame::Frame, gridview::GridView)=ccall(("vtkfigAddGridView",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),frame.cobj,gridview.cobj)

"""
$(TYPEDSIGNATURES)
Add view to frame.
"""
addview!(frame::Frame, gridview::GridView, pos::Int)=ccall(("vtkfigAddGridViewAt",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}, Cint,), frame.cobj,gridview.cobj,pos-1)

"""
$(TYPEDSIGNATURES)
Add view to frame.
"""
addview!(frame::Frame, vectorview::VectorView)=ccall(("vtkfigAddVectorView",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),frame.cobj,vectorview.cobj)

"""
$(TYPEDSIGNATURES)
Add view to frame.
"""
addview!(frame::Frame, vectorview::VectorView, pos::Int)=ccall(("vtkfigAddVectorViewAt",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}, Cint,), frame.cobj,vectorview.cobj,pos-1)

"""
$(TYPEDSIGNATURES)
Add view to frame.
"""
addview!(frame::Frame, xyplot::XYPlot)=ccall(("vtkfigAddXYPlot",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),frame.cobj,xyplot.cobj)

"""
$(TYPEDSIGNATURES)
Add view to frame.
"""
addview!(frame::Frame, xyplot::XYPlot, pos::Int)=ccall(("vtkfigAddXYPlotAt",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}, Cint,), frame.cobj,xyplot.cobj,pos-1)

"""
$(TYPEDSIGNATURES)
Remove  view from frame.
"""
remove!(frame::Frame, scalarview::ScalarView)=ccall(("vtkfigRemoveScalarView",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}), frame.cobj,scalarview.cobj)

"""
$(TYPEDSIGNATURES)
Remove  view from frame.
"""
remove!(frame::Frame, gridview::GridView)=ccall(("vtkfigRemoveGridView",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}), frame.cobj,gridview.cobj)

"""
$(TYPEDSIGNATURES)
Remove  view from frame.
"""
remove!(frame::Frame, vectorview::VectorView)=ccall(("vtkfigRemoveVectorView",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}), frame.cobj,vectorview.cobj)

"""
$(TYPEDSIGNATURES)
Remove  view from frame.
"""
remove!(frame::Frame, xyplot::XYPlot)=ccall(("vtkfigXYPlot",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}), frame.cobj,xyplot.cobj)

"""
$(TYPEDSIGNATURES)
Write frame content to png file.
"""
writepng(frame::Frame,fname)=ccall(("vtkfigWritePNG",libvtkfig), Cvoid, (Ptr{Cvoid},Cstring,), frame.cobj,fname)

"""
$(TYPEDSIGNATURES)
Start video recording.
"""
startvideo(frame::Frame,fname)=ccall(("vtkfigStartVideo",libvtkfig), Cvoid, (Ptr{Cvoid},Cstring,), frame.cobj,fname)

"""
$(TYPEDSIGNATURES)
Stop video recording
"""
stopvideo(frame::Frame)=ccall(("vtkfigStopVideo",libvtkfig),Cvoid, (Ptr{Cvoid},), frame.cobj)

"""
$(TYPEDSIGNATURES)
Set frame size.
"""
size!(frame::Frame,x,y)=ccall(("vtkfigSetSize",libvtkfig), Cvoid, (Ptr{Cvoid},Cint,Cint), frame.cobj,x,y)

"""
$(TYPEDSIGNATURES)
Set frame layout.
"""
layout!(frame::Frame,nrows,ncol)=ccall(("vtkfigSetLayout",libvtkfig), Cvoid, (Ptr{Cvoid},Cint,Cint), frame.cobj,nrows,ncol)

"""
$(TYPEDSIGNATURES)
Set title of window corresponding to frame
"""
windowtitle!(frame::Frame,title)=ccall(("vtkfigSetWindowTitle",libvtkfig), Cvoid, (Ptr{Cvoid},Cstring,),frame.cobj, title)

"""
$(TYPEDSIGNATURES)
Set title in frame
"""
frametitle!(frame::Frame,title)=ccall(("vtkfigSetFrameTitle",libvtkfig), Cvoid, (Ptr{Cvoid},Cstring,), frame.cobj, title)

"""
$(TYPEDSIGNATURES)
Set frame position on screen.
"""
position!(frame::Frame,x,y)=ccall(("vtkfigSetPosition",libvtkfig), Cvoid, (Ptr{Cvoid},Cint,Cint), frame.cobj,x,y)

#######################################################################################################################
# DataSet API

"""
$(TYPEDSIGNATURES)
Create 2D rectilinear grid in dataset.
"""
rectilineargrid!(this::DataSet, X::Vector{Cdouble},Y::Vector{Cdouble})=ccall( ("vtkfigSetRectilinearGrid2D",libvtkfig), Cvoid,(Ptr{Cvoid},Ptr{Cdouble},Cint,Ptr{Cdouble},Cint), this.cobj,X, length(X),Y,length(Y))

"""
$(TYPEDSIGNATURES)
Create 3D rectilinear grid in dataset.
"""
rectilineargrid!(this::DataSet, X::Vector{Cdouble},Y::Vector{Cdouble},Z::Vector{Cdouble})=ccall( ("vtkfigSetRectilinearGrid3D",libvtkfig), Cvoid,(Ptr{Cvoid},Ptr{Cdouble},Cint,Ptr{Cdouble},Cint,Ptr{Cdouble},Cint), this.cobj,X,length(X),Y,length(Y),Z,length(Z))

"""
$(TYPEDSIGNATURES)
Create simplex grid in dataset.
"""
simplexgrid!(this::DataSet, Points::Array{Cdouble,2},Cells::Array{Cint,2})=ccall( ("vtkfigSetSimplexGrid",libvtkfig), Cvoid,(Ptr{Cvoid},Cint,Ptr{Cdouble},Cint,Ptr{Cint},Cint), this.cobj,size(Points,1),Points,size(Points,2),Cells,size(Cells,2))

"""
$(TYPEDSIGNATURES)
Add piece wise linear function with identifier `name` to dataset.
"""
pointscalar!(this::DataSet, X::Vector{Cdouble},name)=ccall(("vtkfigSetPointScalar",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cdouble},Cint,Cstring), this.cobj,X, length(X),name)

"""
$(TYPEDSIGNATURES)
Add piece wise linear function with identifier `name` to dataset.
"""
pointvector!(this::DataSet, UVW::Array{Cdouble,2},name)=ccall(("vtkfigSetPointVector",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cdouble},Cint,Cint,Cstring), this.cobj,UVW, size(UVW)[2],size(UVW)[1],name)


"""
$(TYPEDSIGNATURES)
Write data set content to vtk file.
"""
writevtk(this::DataSet,fname; ftype="A")=ccall( ("vtkfigWriteVTK",libvtkfig), Cvoid, (Ptr{Cvoid},Cstring,Cstring,), this.cobj,fname,ftype)

#######################################################################################################################
# ScalarView API

"""
$(TYPEDSIGNATURES)
Set data to be shown to point scalar `name` in dataset.
"""
data!(this::ScalarView, dataset::DataSet,name)=ccall(("vtkfigSetScalarViewData",libvtkfig),Cvoid, (Ptr{Cvoid},Ptr{Cvoid},Cstring),this.cobj,dataset.cobj,name)

"""
$(TYPEDSIGNATURES)
Set isolevels for isocontour and isosurface plot.
"""
isolevels!(this::ScalarView, V::Vector{Cdouble})=ccall(("vtkfigSetIsolevels",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cdouble},Cint), this.cobj,V, length(V))

"""
$(TYPEDSIGNATURES)
Toggle display of isosurfaces in 3D plot.
"""
show_isosurfaces!(this::ScalarView,b::Bool)=ccall(("vtkfigShowIsosurfaces",libvtkfig), Cvoid,(Ptr{Cvoid},Cint), this.cobj,Int(b))

#######################################################################################################################
# VectorView API

"""
$(TYPEDSIGNATURES)
Set data to be shown to point scalar `name` in dataset.
"""
data!(this::VectorView, dataset::DataSet,name)=ccall(("vtkfigSetVectorViewData",libvtkfig),Cvoid, (Ptr{Cvoid},Ptr{Cvoid},Cstring),this.cobj,dataset.cobj,name)

quiver!(this::VectorView, nx,ny)=ccall(("vtkfigSetQuiverGrid2D",libvtkfig), Cvoid,(Ptr{Cvoid},Cint, Cint), this.cobj,nx,ny)

quiver!(this::VectorView, nx,ny,nz)=ccall(("vtkfigSetQuiverGrid3D",libvtkfig), Cvoid,(Ptr{Cvoid},Cint, Cint,Cint), this.cobj,nx,ny,nz)

#######################################################################################################################
# GridView API

"""
$(TYPEDSIGNATURES)
Set data to be shown to grid defined in dataset.
"""
data!(this::GridView, dataset::DataSet)=ccall(("vtkfigSetGridViewData",libvtkfig),Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),this.cobj,dataset.cobj)


#######################################################################################################################
# XYPlot API

"""
$(TYPEDSIGNATURES)
Add  one paticular plot ("series") to XYPlot object.
"""
addplot!(this::XYPlot, X::Vector{Cdouble},Y::Vector{Cdouble})=ccall(("vtkfigAddPlot",libvtkfig), Cvoid,(Ptr{Cvoid},Ptr{Cdouble},Cint,Ptr{Cdouble},Cint), this.cobj,X, length(X),Y,length(Y))
    
"""
$(TYPEDSIGNATURES)
Set plot title.
"""
title!(this::XYPlot,title)=ccall(("vtkfigSetTitle",libvtkfig),Cvoid,(Ptr{Cvoid},Cstring), this.cobj,title); 

"""
$(TYPEDSIGNATURES)
Toggle display of legend in plot.
"""
show_legend!(this::XYPlot,b::Bool)=ccall(("vtkfigShowLegend",libvtkfig), Cvoid,(Ptr{Cvoid},Cint), this.cobj,Int(b))

"""
$(TYPEDSIGNATURES)
Toggle display of background grid in plot.
"""
show_grid!(this::XYPlot,b::Bool)=ccall(("vtkfigShowGrid",libvtkfig),Cvoid,(Ptr{Cvoid},Cint), this.cobj,Int(b))

"""
$(TYPEDSIGNATURES)
Toggle automatic label adjustment.
"""
adjust_labels!(this::XYPlot,b::Bool)=ccall(("vtkfigAdjustLabels",libvtkfig), Cvoid,(Ptr{Cvoid},Cint), this.cobj,Int(b))

"""
$(TYPEDSIGNATURES)
Clear all data from plot.
"""
clear!(this::XYPlot)=ccall(("vtkfigClear",libvtkfig),Cvoid,(Ptr{Cvoid},),this.cobj)

"""
$(TYPEDSIGNATURES)
Set legend position.
"""
legendposition!(this::XYPlot,x,y)=ccall(("vtkfigSetLegendPosition",libvtkfig), Cvoid,(Ptr{Cvoid},Cdouble, Cdouble,),this.cobj,x,y)

"""
$(TYPEDSIGNATURES)
Sed legend size.
"""
legendsize!(this::XYPlot,w,h)=ccall(("vtkfigSetLegendSize",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble, Cdouble,),this.cobj,w,h)

"""
$(TYPEDSIGNATURES)
Line type of next plot.
"""
plotlinetype!(this::XYPlot, ltype)=ccall(("vtkfigSetPlotLineType",libvtkfig),Cvoid,(Ptr{Cvoid},Cstring),this.cobj,ltype) 

"""
$(TYPEDSIGNATURES)
Marker type of next plot.
"""
plotmarkertype!(this::XYPlot,mtype)=ccall(("vtkfigSetPlotMarkerType",libvtkfig), Cvoid,(Ptr{Cvoid},Cstring), this.cobj,mtype) 

"""
$(TYPEDSIGNATURES)
Color of next plot.
"""
plotcolor!(this::XYPlot,r,g,b)=ccall(("vtkfigSetPlotColor",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble,Cdouble,Cdouble,),this.cobj,r,g,b) 

"""
$(TYPEDSIGNATURES)
Legend of next plot.
"""
plotlegend!(this::XYPlot, legend)=ccall(("vtkfigSetPlotLegend",libvtkfig),Cvoid,(Ptr{Cvoid},Cstring,),this.cobj,legend) 

"""
$(TYPEDSIGNATURES)
Color of background grid.
"""
gridcolor!(this::XYPlot,r,g,b)=ccall(("vtkfigSetGridColor",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble,Cdouble,Cdouble,), this.cobj,r,g,b) 

"""
$(TYPEDSIGNATURES)
Color of axes.
"""
axescolor!(this::XYPlot,r,g,b)=ccall(("vtkfigSetAxesColor",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble,Cdouble,Cdouble,), this.cobj,r,g,b) 

"""
$(TYPEDSIGNATURES)
X Axis title.
"""
xtitle!(this::XYPlot,title)=ccall(("vtkfigSetXTitle",libvtkfig),Cvoid,(Ptr{Cvoid},Cstring), this.cobj,title) 

"""
$(TYPEDSIGNATURES)
Y Axis title.
"""
ytitle!(this::XYPlot,title)=ccall(("vtkfigSetYTitle",libvtkfig), Cvoid,(Ptr{Cvoid},Cstring), this.cobj,title) 

"""
$(TYPEDSIGNATURES)
Linewidth of next plot.
"""
linewidth!(this::XYPlot,w)=ccall(("vtkfigSetLineWidth",libvtkfig), Cvoid,(Ptr{Cvoid},Cdouble,),this.cobj,w)

"""
$(TYPEDSIGNATURES)
Marker size of next plot.
"""
markersize!(this::XYPlot,s)=ccall(("vtkfigSetMarkerSize",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble,),this.cobj,s)

"""
$(TYPEDSIGNATURES)
Range of X coordinates.
"""
xrange!(this::XYPlot, x0,x1)=ccall(("vtkfigSetXRange",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble, Cdouble), this.cobj,x0,x1) 

"""
$(TYPEDSIGNATURES)
Range of Y coordinates.
"""
yrange!(this::XYPlot, y0,y1)=ccall(("vtkfigSetYRange",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble, Cdouble), this.cobj,y0,y1) 

"""
$(TYPEDSIGNATURES)
Number of labels on X axis.
"""
numberofxlabels!(this::XYPlot,n)=ccall(("vtkfigSetNumberOfXLabels",libvtkfig), Cvoid,(Ptr{Cvoid},Cint,),this.cobj,n)

"""
$(TYPEDSIGNATURES)
Number of labels on Y axis.
"""
numberofylabels!(this::XYPlot,n)=ccall(("vtkfigSetNumberOfYLabels",libvtkfig),Cvoid,(Ptr{Cvoid},Cint,), this.cobj,n)


#################################################################################################################
# Delaunay grid generation API
mutable struct vtkfigSimplexGrid
    dim::Cint
    npoints::Cint
    ncells::Cint
    points::Ptr{Cdouble}
    cells::Ptr{Cint}
    vtkfigSimplexGrid()=new()
end


delaunay!(this::vtkfigSimplexGrid, inpoints::Array{Cdouble,2})=ccall(("vtkfigDelaunay",libvtkfig),Cvoid,
                                                                     (Ref{vtkfigSimplexGrid},Ptr{Cdouble},Cint,Cint,),
                                                                     Ref(this),inpoints,size(inpoints,1),size(inpoints,2))
