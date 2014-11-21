## App: Current-Potential Model by Butler-Volmer Equation

library(shiny)
library(ggplot2)

shinyServer(
        function(input, output) {
                                
        ## Display the exchange current denisy and charge transfer coefficient
        output$j0out <- renderPrint({input$j0})
        output$alphaout <- renderPrint({input$alpha})  
       
        ## Calculate and plot current density VS overpotential
        output$graph1 <- renderPlot({
                j0 <- input$j0          # exchange current density
                alpha <- input$alpha    # charge transfer coefficient
                ne <- 2                 # number of electron
                temp <- 298             # temperature 
                Far <- 96485            # Faraday constant
                Rgas <- 8.314           # gas constant
                
                ## calculate current density (j) VS overpotential (eta)
                ## using Butler-Volmer Equation
                eta <- seq(-0.1, 0.1, 0.001)
                j <- j0*(exp((1-alpha)*ne*Far*eta/Rgas/temp)
                         -exp(-alpha*ne*Far*eta/Rgas/temp)) 
                dataout <- data.frame(cbind(eta,j))
                names(dataout) <- c("eta", "j")
                
                ## plot current density VS overpotential
                g1 <- (ggplot(dataout, aes(x=eta, y=j))
                       + geom_line()
                       + ggtitle("Current Density VS Overpotential")
                       + scale_x_continuous(name="Overpotential (V)",limits=c(-0.1,0.1))
                       + scale_y_continuous(name="Current Density (A/m2)",limits=c(-5,5)))                     
                print(g1)                          
        })
       
        }
)

