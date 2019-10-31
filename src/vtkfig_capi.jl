###########################################################################

const libvtkfig="libvtkfig.so"

const errorstring=
"""
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1

Package VTKFig: Unable to open libvtkfig.so.

Please ensure  to have  compiled the  vtkfig package  and to  have the
directory containing libvtkfig.so on your LD_LIBRARY_PATH.

For detailed instructions, see  https://github.com/j-fu/vtkfig .

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
"""


function __init__()
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

function XYPlot(this::XYPlot)
    this.cobj=ccall( ("vtkfigCreateXYPlot",libvtkfig), Ptr{Cvoid}, ())
    finalizer(destruct!,this)
    return this
end

destruct!(this::XYPlot)=ccall( ("vtkfigDestroyXYPlot",libvtkfig), Cvoid, (Ptr{Cvoid},),this.cobj)



###########################################################################

interact(this::Frame)=ccall(("vtkfigInteract",libvtkfig),Cvoid,(Ptr{Cvoid},),this.cobj)

show(this::Frame)=ccall(("vtkfigShow",libvtkfig),Cvoid,(Ptr{Cvoid},),this.cobj)

clear(this::Frame)=ccall(("vtkfigClearFrame",libvtkfig),Cvoid,(Ptr{Cvoid},),this.cobj)

add_figure(this::Frame, fig::ScalarView)=ccall(("vtkfigAddScalarView",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),this.cobj,fig.cobj)

add_figure(this::Frame, fig::ScalarView, pos::Int)=ccall(("vtkfigAddScalarViewAt",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}, Cint,), this.cobj,fig.cobj,pos-1)

add_figure(this::Frame, fig::GridView)=ccall(("vtkfigAddGridView",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),this.cobj,fig.cobj)

add_figure(this::Frame, fig::GridView, pos::Int)=ccall(("vtkfigAddGridViewAt",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}, Cint,), this.cobj,fig.cobj,pos-1)

add_figure(this::Frame, fig::VectorView)=ccall(("vtkfigAddVectorView",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),this.cobj,fig.cobj)

add_figure(this::Frame, fig::VectorView, pos::Int)=ccall(("vtkfigAddVectorViewAt",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}, Cint,), this.cobj,fig.cobj,pos-1)

add_figure(this::Frame, fig::XYPlot)=ccall(("vtkfigAddXYPlot",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}),this.cobj,fig.cobj)

add_figure(this::Frame, fig::XYPlot, pos::Int)=ccall(("vtkfigAddXYPlotAt",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}, Cint,), this.cobj,fig.cobj,pos-1)

remove_figure(this::Frame, fig::ScalarView)=ccall(("vtkfigRemoveScalarView",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}), this.cobj,fig.cobj)

remove_figure(this::Frame, fig::GridView)=ccall(("vtkfigRemoveGridView",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}), this.cobj,fig.cobj)

remove_figure(this::Frame, fig::VectorView)=ccall(("vtkfigRemoveVectorView",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}), this.cobj,fig.cobj)

remove_figure(this::Frame, fig::XYPlot)=ccall(("vtkfigXYPlot",libvtkfig), Cvoid, (Ptr{Cvoid},Ptr{Cvoid}), this.cobj,fig.cobj)

write_png(this::Frame,fname)=ccall(("vtkfigWritePNG",libvtkfig), Cvoid, (Ptr{Cvoid},Cstring,), this.cobj,fname)

start_video(this::Frame,fname)=ccall(("vtkfigStartVideo",libvtkfig), Cvoid, (Ptr{Cvoid},Cstring,), this.cobj,fname)

stop_video(this::Frame,fname)=ccall(("vtkfigStopVideo",libvtkfig),Cvoid, (Ptr{Cvoid},), this.cobj)

set_size(this::Frame,x,y)=ccall(("vtkfigSetSize",libvtkfig), Cvoid, (Ptr{Cvoid},Cint,Cint), this.cobj,x,y)

set_layout(this::Frame,x,y)=ccall(("vtkfigSetLayout",libvtkfig), Cvoid, (Ptr{Cvoid},Cint,Cint), this.cobj,x,y)

set_window_title(this::Frame,title)=ccall(("vtkfigSetWindowTitle",libvtkfig), Cvoid, (Ptr{Cvoid},Cstring,),this.cobj, title)

set_frame_title(this::Frame,title)=ccall(("vtkfigSetFrameTitle",libvtkfig), Cvoid, (Ptr{Cvoid},Cstring,), this.cobj, title)

set_position(this::Frame,x,y)=ccall(("vtkfigSetPosition",libvtkfig), Cvoid, (Ptr{Cvoid},Cint,Cint), this.cobj,x,y)

