#
# Alternative API based on a static frame "sitting" in the background which
# persists during a julia session. Similar to the behavior of gr and pyplot.
#

# Variable holding static frame
_static_frame=nothing

# Return static frame, and create it if it doesnt exist
function StaticFrame()
    global _static_frame
    if _static_frame==nothing
        _static_frame=Frame()
    end
    return _static_frame
end

# Destroy static frame - do we really need  this ?
function destroy_static_frame()
    global _static_frame
    if _static_frame!=nothing
        destruct!(_static_frame)
    end
    _static_frame=nothing
end

