###########################################################################

const libvtkfig="libvtkfig.so"

const errorstring=
"""
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1

Package VTKView: Unable to open libvtkfig.so.

Please ensure  to have  compiled the  vtkfig package  and to  have the
directory containing libvtkfig.so on your LD_LIBRARY_PATH.

For detailed instructions, see  https://github.com/j-fu/vtkfig .

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
"""


function __init__()
    if ENV["MAKEDOCS"]=="1"
        return
    end
    if VERSION >= v"1.1" 
        lib=something(Libdl.dlopen(libvtkfig,Libdl.RTLD_NOW, throw_error=true), C_NULL)
    else
        lib=something(Libdl.dlopen_e(libvtkfig,Libdl.RTLD_NOW),C_NULL)
    end        
    if lib==C_NULL
        println(errorstring)
        throw(LoadError("",0,""))
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
$(SIGNATURES)
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
$(SIGNATURES)
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
$(SIGNATURES)
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
$(SIGNATURES)
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
$(SIGNATURES)
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
$(SIGNATURES)
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
$(SIGNATURES)
Display frame content and enter interaction mode.
"""
interact(this::Frame)=ccall(("vtkfigInteract",libvtkfig),Cvoid,(Ptr{Cvoid},),this.cobj)

"""
$(SIGNATURES)
Display frame content and continue.
"""
Base.display(this::Frame)=ccall(("vtkfigShow",libvtkfig),Cvoid,(Ptr{Cvoid},),this.cobj)

"""
$(SIGNATURES)
Clear frame content.
"""
clear!(this::Frame)=ccall(("vtkfigClearFrame",libvtkfig),Cvoid,(Ptr{Cvoid},),this.cobj)

"""
$(SIGNATURES)
Add view to frame.
"""
addview!(this::Frame, fig::ScalarView)=ccall(("vtkfigAddScalarView",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),this.cobj,fig.cobj)

"""
$(SIGNATURES)
Add view to frame.
"""
addview!(this::Frame, fig::ScalarView, pos::Int)=ccall(("vtkfigAddScalarViewAt",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}, Cint,), this.cobj,fig.cobj,pos-1)

"""
$(SIGNATURES)
Add view to frame.
"""
addview!(this::Frame, fig::GridView)=ccall(("vtkfigAddGridView",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),this.cobj,fig.cobj)

"""
$(SIGNATURES)
Add view to frame.
"""
addview!(this::Frame, fig::GridView, pos::Int)=ccall(("vtkfigAddGridViewAt",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}, Cint,), this.cobj,fig.cobj,pos-1)

"""
$(SIGNATURES)
Add view to frame.
"""
addview!(this::Frame, fig::VectorView)=ccall(("vtkfigAddVectorView",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),this.cobj,fig.cobj)

"""
$(SIGNATURES)
Add view to frame.
"""
addview!(this::Frame, fig::VectorView, pos::Int)=ccall(("vtkfigAddVectorViewAt",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}, Cint,), this.cobj,fig.cobj,pos-1)

"""
$(SIGNATURES)
Add view to frame.
"""
addview!(this::Frame, fig::XYPlot)=ccall(("vtkfigAddXYPlot",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),this.cobj,fig.cobj)

"""
$(SIGNATURES)
Add view to frame.
"""
addview!(this::Frame, fig::XYPlot, pos::Int)=ccall(("vtkfigAddXYPlotAt",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}, Cint,), this.cobj,fig.cobj,pos-1)

"""
$(SIGNATURES)
Remove  view from frame.
"""
remove!(this::Frame, fig::ScalarView)=ccall(("vtkfigRemoveScalarView",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}), this.cobj,fig.cobj)

"""
$(SIGNATURES)
Remove  view from frame.
"""
remove!(this::Frame, fig::GridView)=ccall(("vtkfigRemoveGridView",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}), this.cobj,fig.cobj)

"""
$(SIGNATURES)
Remove  view from frame.
"""
remove!(this::Frame, fig::VectorView)=ccall(("vtkfigRemoveVectorView",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}), this.cobj,fig.cobj)

"""
$(SIGNATURES)
Remove  view from frame.
"""
remove!(this::Frame, fig::XYPlot)=ccall(("vtkfigXYPlot",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}), this.cobj,fig.cobj)

"""
$(SIGNATURES)
Remove  view from frame.
"""
writepng(this::Frame,fname)=ccall(("vtkfigWritePNG",libvtkfig), Cvoid, (Ptr{Cvoid},Cstring,), this.cobj,fname)

"""
$(SIGNATURES)
Remove  view from frame.
"""
startvideo(this::Frame,fname)=ccall(("vtkfigStartVideo",libvtkfig), Cvoid, (Ptr{Cvoid},Cstring,), this.cobj,fname)

"""
$(SIGNATURES)
Remove  view from frame.
"""
stopvideo(this::Frame)=ccall(("vtkfigStopVideo",libvtkfig),Cvoid, (Ptr{Cvoid},), this.cobj)

"""
$(SIGNATURES)
Remove  view from frame.
"""
size!(this::Frame,x,y)=ccall(("vtkfigSetSize",libvtkfig), Cvoid, (Ptr{Cvoid},Cint,Cint), this.cobj,x,y)

"""
$(SIGNATURES)
Remove  view from frame.
"""
layout!(this::Frame,x,y)=ccall(("vtkfigSetLayout",libvtkfig), Cvoid, (Ptr{Cvoid},Cint,Cint), this.cobj,x,y)

"""
$(SIGNATURES)
Remove  view from frame.
"""
windowtitle!(this::Frame,title)=ccall(("vtkfigSetWindowTitle",libvtkfig), Cvoid, (Ptr{Cvoid},Cstring,),this.cobj, title)

"""
$(SIGNATURES)
Remove  view from frame.
"""
frametitle!(this::Frame,title)=ccall(("vtkfigSetFrameTitle",libvtkfig), Cvoid, (Ptr{Cvoid},Cstring,), this.cobj, title)

"""
$(SIGNATURES)
Remove  view from frame.
"""
position!(this::Frame,x,y)=ccall(("vtkfigSetPosition",libvtkfig), Cvoid, (Ptr{Cvoid},Cint,Cint), this.cobj,x,y)

#######################################################################################################################
# DataSet API

"""
$(SIGNATURES)
Create 2D rectilinear grid in dataset.
"""
rectilineargrid!(this::DataSet, X::Vector{Cdouble},Y::Vector{Cdouble})=ccall( ("vtkfigSetRectilinearGrid2D",libvtkfig), Cvoid,(Ptr{Cvoid},Ptr{Cdouble},Cint,Ptr{Cdouble},Cint), this.cobj,X, length(X),Y,length(Y))

"""
$(SIGNATURES)
Create 3D rectilinear grid in dataset.
"""
rectilineargrid!(this::DataSet, X::Vector{Cdouble},Y::Vector{Cdouble},Z::Vector{Cdouble})=ccall( ("vtkfigSetRectilinearGrid3D",libvtkfig), Cvoid,(Ptr{Cvoid},Ptr{Cdouble},Cint,Ptr{Cdouble},Cint,Ptr{Cdouble},Cint), this.cobj,X,length(X),Y,length(Y),Z,length(Z))

"""
$(SIGNATURES)
Create simplex grid in dataset.
"""
simplexgrid!(this::DataSet, Points::Array{Cdouble,2},Cells::Array{Cint,2})=ccall( ("vtkfigSetSimplexGrid",libvtkfig), Cvoid,(Ptr{Cvoid},Cint,Ptr{Cdouble},Cint,Ptr{Cint},Cint), this.cobj,size(Points,1),Points,size(Points,2),Cells,size(Cells,2))

"""
$(SIGNATURES)
Add piece wise linear function with identifier `name` to dataset.
"""
addpointscalar!(this::DataSet, X::Vector{Cdouble},name)=ccall(("vtkfigSetPointScalar",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cdouble},Cint,Cstring), this.cobj,X, length(X),name)

"""
$(SIGNATURES)
Write data set content to vtk file.
"""
writevtk(this::DataSet,fname; ftype="A")=ccall( ("vtkfigWriteVTK",libvtkfig), Cvoid, (Ptr{Cvoid},Cstring,Cstring,), this.cobj,fname,ftype)

#######################################################################################################################
# ScalarView API

"""
$(SIGNATURES)
Set data to be shown to point scalar `name` in dataset.
"""
data!(this::ScalarView, dataset::DataSet,name)=ccall(("vtkfigSetScalarViewData",libvtkfig),Cvoid, (Ptr{Cvoid},Ptr{Cvoid},Cstring),this.cobj,dataset.cobj,name)

"""
$(SIGNATURES)
Set isolevels for isocontour and isosurface plot.
"""
isolevels!(this::ScalarView, V::Vector{Cdouble})=ccall(("vtkfigSetIsolevels",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cdouble},Cint), this.cobj,V, length(V))

"""
$(SIGNATURES)
Toggle display of isosurfaces in 3D plot.
"""
show_isosurfaces!(this::ScalarView,b::Bool)=ccall(("vtkfigShowIsosurfaces",libvtkfig), Cvoid,(Ptr{Cvoid},Cint), this.cobj,Int(b))

#######################################################################################################################
# GridView API

"""
$(SIGNATURES)
Set data to be shown to grid defined in dataset.
"""
data!(this::GridView, dataset::DataSet)=ccall(("vtkfigSetGridViewData",libvtkfig),Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),this.cobj,dataset.cobj)


#######################################################################################################################
# XYPlot API

"""
$(SIGNATURES)
Add  one paticular plot ("series") to XYPlot object.
"""
addplot!(this::XYPlot, X::Vector{Cdouble},Y::Vector{Cdouble})=ccall(("vtkfigAddPlot",libvtkfig), Cvoid,(Ptr{Cvoid},Ptr{Cdouble},Cint,Ptr{Cdouble},Cint), this.cobj,X, length(X),Y,length(Y))
    
"""
$(SIGNATURES)
Set plot title.
"""
title!(this::XYPlot,title)=ccall(("vtkfigSetTitle",libvtkfig),Cvoid,(Ptr{Cvoid},Cstring), this.cobj,title); 

"""
$(SIGNATURES)
Toggle display of legend in plot.
"""
show_legend!(this::XYPlot,b::Bool)=ccall(("vtkfigShowLegend",libvtkfig), Cvoid,(Ptr{Cvoid},Cint), this.cobj,Int(b))

"""
$(SIGNATURES)
Toggle display of background grid in plot.
"""
show_grid!(this::XYPlot,b::Bool)=ccall(("vtkfigShowGrid",libvtkfig),Cvoid,(Ptr{Cvoid},Cint), this.cobj,Int(b))

"""
$(SIGNATURES)
Toggle automatic label adjustment.
"""
adjust_labels!(this::XYPlot,b::Bool)=ccall(("vtkfigAdjustLabels",libvtkfig), Cvoid,(Ptr{Cvoid},Cint), this.cobj,Int(b))

"""
$(SIGNATURES)
Clear all data from plot.
"""
clear!(this::XYPlot)=ccall(("vtkfigClear",libvtkfig),Cvoid,(Ptr{Cvoid},),this.cobj)

"""
$(SIGNATURES)
Set legend position.
"""
legendposition!(this::XYPlot,x,y)=ccall(("vtkfigSetLegendPosition",libvtkfig), Cvoid,(Ptr{Cvoid},Cdouble, Cdouble,),this.cobj,x,y)

"""
$(SIGNATURES)
Sed legend size.
"""
legendsize!(this::XYPlot,w,h)=ccall(("vtkfigSetLegendSize",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble, Cdouble,),this.cobj,w,h)

"""
$(SIGNATURES)
Line type of next plot.
"""
plotlinetype!(this::XYPlot, ltype)=ccall(("vtkfigSetPlotLineType",libvtkfig),Cvoid,(Ptr{Cvoid},Cstring),this.cobj,ltype) 

"""
$(SIGNATURES)
Marker type of next plot.
"""
plotmarkertype!(this::XYPlot,mtype)=ccall(("vtkfigSetPlotMarkerType",libvtkfig), Cvoid,(Ptr{Cvoid},Cstring), this.cobj,mtype) 

"""
$(SIGNATURES)
Color of next plot.
"""
plotcolor!(this::XYPlot,r,g,b)=ccall(("vtkfigSetPlotColor",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble,Cdouble,Cdouble,),this.cobj,r,g,b) 

"""
$(SIGNATURES)
Legend of next plot.
"""
plotlegend!(this::XYPlot, legend)=ccall(("vtkfigSetPlotLegend",libvtkfig),Cvoid,(Ptr{Cvoid},Cstring,),this.cobj,legend) 

"""
$(SIGNATURES)
Color of background grid.
"""
gridcolor!(this::XYPlot,r,g,b)=ccall(("vtkfigSetGridColor",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble,Cdouble,Cdouble,), this.cobj,r,g,b) 

"""
$(SIGNATURES)
Color of axes.
"""
axescolor!(this::XYPlot,r,g,b)=ccall(("vtkfigSetAxesColor",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble,Cdouble,Cdouble,), this.cobj,r,g,b) 

"""
$(SIGNATURES)
X Axis title.
"""
xtitle!(this::XYPlot,title)=ccall(("vtkfigSetXTitle",libvtkfig),Cvoid,(Ptr{Cvoid},Cstring), this.cobj,title) 

"""
$(SIGNATURES)
Y Axis title.
"""
ytitle!(this::XYPlot,title)=ccall(("vtkfigSetYTitle",libvtkfig), Cvoid,(Ptr{Cvoid},Cstring), this.cobj,title) 

"""
$(SIGNATURES)
Linewidth of next plot.
"""
linewidth!(this::XYPlot,w)=ccall(("vtkfigSetLineWidth",libvtkfig), Cvoid,(Ptr{Cvoid},Cdouble,),this.cobj,w)

"""
$(SIGNATURES)
Marker size of next plot.
"""
markersize!(this::XYPlot,s)=ccall(("vtkfigSetMarkerSize",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble,),this.cobj,s)

"""
$(SIGNATURES)
Range of X coordinates.
"""
xrange!(this::XYPlot, x0,x1)=ccall(("vtkfigSetXRange",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble, Cdouble), this.cobj,x0,x1) 

"""
$(SIGNATURES)
Range of Y coordinates.
"""
yrange!(this::XYPlot, y0,y1)=ccall(("vtkfigSetYRange",libvtkfig),Cvoid,(Ptr{Cvoid},Cdouble, Cdouble), this.cobj,y0,y1) 

"""
$(SIGNATURES)
Number of labels on X axis.
"""
numberofxlabels!(this::XYPlot,n)=ccall(("vtkfigSetNumberOfXLabels",libvtkfig), Cvoid,(Ptr{Cvoid},Cint,),this.cobj,n)

"""
$(SIGNATURES)
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
