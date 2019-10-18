#
# Alternative API based on a static frame "sitting" in the background which
# persists during a julia session. Similar to the behavior of gr and pyplot.
#

# Variable holding static frame
StaticFrame=nothing

# Return static frame, and create it if it doesnt exist
function static_frame()
    global StaticFrame
    if StaticFrame==nothing
        StaticFrame=Frame()
    end
    return StaticFrame
end

# Destroy static frame - do we really need  this ?
function destroy_static_frame()
    global StaticFrame
    if StaticFrame!=nothing
        destruct!(StaticFrame)
    end
    StaticFrame=nothing
end

#
# Static frame  versions of vtkfig methods
#

interact()=interact(static_frame())

show()=show(static_frame())

clear()=clear(static_frame())

add_figure(fig::ScalarView)=add_figure(static_frame(), fig::ScalarView)

add_figure(fig::ScalarView, pos::Int)=add_figure(static_frame(), fig::ScalarView, pos::Int)

add_figure(fig::GridView)=add_figure(static_frame(), fig::GridView)

add_figure(fig::GridView, pos::Int)=add_figure(static_frame(), fig::GridView, pos::Int)

add_figure(fig::VectorView)=add_figure(static_frame(), fig::VectorView)

add_figure(fig::VectorView, pos::Int)=add_figure(static_frame(), fig::VectorView, pos::Int)

add_figure(fig::XYPlot)=add_figure(static_frame(), fig::XYPlot)

add_figure(fig::XYPlot, pos::Int)=add_figure(static_frame(), fig::XYPlot, pos::Int)

remove_figure(fig::ScalarView)=remove_figure(static_frame(), fig::ScalarView)

remove_figure(fig::GridView)=remove_figure(static_frame(), fig::GridView)

remove_figure(fig::VectorView)=remove_figure(static_frame(), fig::VectorView)

remove_figure(fig::XYPlot)=remove_figure(static_frame(), fig::XYPlot)

write_png(fname)=write_png(static_frame(),fname)

start_video(fname)=start_video(static_frame(),fname)

stop_video(fname)=stop_video(static_frame(),fname)

set_size(x,y)=set_size(static_frame(),x,y)

set_layout(x,y)=set_layout(static_frame(),x,y)

set_window_title(title)=set_window_title(static_frame(),title)

set_frame_title(title)=set_frame_title(static_frame(),title)

set_position(x,y)=set_position(static_frame(),x,y)
