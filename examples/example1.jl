module Example1
#########################################################################################
using VTKFig



###########################################################################
function G(x::T,y::T,t::T) where T 
    return exp(-(x*x+y*y))*sin(t+9.0*x)*cos(11.0*y-2.0*t)
end


function main(;nspin=50)

    VTKFig.clear()
    h=0.01
    X=collect(0:h:1.0)
    Y=collect(0:h:1.2)
    Z=zeros(Float64,length(X),length(Y))
    griddata=VTKFig.DataSet()
    contour=VTKFig.ScalarView()
    set_layout(2,1)
    set_size(600,300)
    set_rectilinear_grid(griddata,X,Y) 

    set_point_scalar(griddata,vec(Z),"V")
    set_data(contour,griddata,"V")
    add_figure(contour,1)

    plot=VTKFig.XYPlot()
    add_figure(plot,2)
    
    
    ii=1
    t=0.0
    dt=0.1
    while ii<nspin
        @time for i=1:length(X)
            for j=1:length(Y)
                Z[i,j] = G(X[i],Y[j],t)
            end
        end
        set_point_scalar(griddata,vec(Z),"V")
        clear(plot)
        set_plot_legend(plot,"j=1")
        set_plot_color(plot,1,0,0)
        add_plot(plot,X,Z[:,1])

        set_plot_color(plot,0,0,1)
        set_plot_legend(plot,"i=1")
        add_plot(plot,Y,Z[1,:])

        VTKFig.show()
        t+=dt
        ii+=1
    end
    write_png("test1.png")
    write_vtk(griddata,"test1.vtk")
end





end
