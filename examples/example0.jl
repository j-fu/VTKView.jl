
#########################################################################################
using VTKFig



###########################################################################


function main()
    h=0.01
    X=collect(0:h:1.0)
    Y=collect(0:h:1.2)
    Z=zeros(length(X),length(Y))
    
    frame=VTKFig.Frame()
    griddata=VTKFig.DataSet()
    contour=VTKFig.ScalarView()
    set_layout(frame,2,1)
    set_size(frame,600,300)
    set_rectilinear_grid(griddata,X,Y)

    set_point_scalar(griddata,vec(Z),"V")
    set_data(contour,griddata,"V")
    add_figure(frame,contour,1)

    plot=VTKFig.XYPlot()
    add_figure(frame,plot,2)
    
    function G(x,y,t) 
        return exp(-(x*x+y*y))*sin(t+x)*cos(y-t)
    end
    
    nspin=500
    ii=1
    t=0.0
    dt=0.1
    while ii<nspin
        for i=1:length(X)
            for j=1:length(Y)
                Z[i,j] = G(X[i],Y[j],t)
            end
        end
        set_point_scalar(griddata,vec(Z),"V")
        clear(plot)
        set_plot_legend(plot,"j=1")
        add_plot(plot,X,Z[:,1])
        set_plot_legend(plot,"i=1")
        add_plot(plot,Y,Z[1,:])

        VTKFig.show(frame)
        t+=dt
        ii+=1
    end
    write_png(frame,"test.png")
    write_vtk(griddata,"test.vtk")
    VTKFig.interact(frame)
end


#VTKFig.test()
#print_openglinfo()
main()



