## App: Current-Potential Relationship by Butler-Volmer Equation

library(shiny)
library(ggplot2)

shinyUI(pageWithSidebar(
        headerPanel("Current-Potential Model (Electrochemistry)"),
        
        sidebarPanel(
                
                h3("App Summary"),
                strong(HTML("This Shiny App produces a graph illustrating
                  the effects of kinetic parameters charge
                  transfer coefficient (&alpha;) and 
                  exchange currenty density (j0), 
                  on current density(j)-overpotential(&eta;) relationship 
                  predicted by the Butler-Volmer equation.")),
                br(),
                
                h3("Instruction"),              
                p(HTML("1. Adjust the model inputs: charge transfer
                  coefficient (&alpha;) and exchange current density
                  (j0) using the sliders")),
                p(HTML("2. The resulting current density(j)-overpotential(&eta;)
                  plot will be displayed under Result.")),
                br(),
                
                h4("Input"),
                sliderInput("j0", 
                            label=p("Exchange current density (j0):"), 
                            min=0.001, max=0.1, value=0.05, step=0.001),
                sliderInput("alpha", 
                            label=p(HTML("Charge transfer coefficient (&alpha;):")), 
                            min=0, max=1, value=0.5, step=0.01)                
        ),
        
        mainPanel(      
                h3("Background"),
                p("The relationship between electrical current 
                  and electrode potential for electrochemical 
                  reactions is described by the  Butler-Volmer equation:"),
                p(HTML("j = j0 { exp[(1-&alpha;)nF&eta;/(RT)] - 
                       exp[-&alpha;nF&eta;/(RT)] }")),
                tags$div(
                        HTML(paste("j is current density (A/m", tags$sup(2), sep = "")), 
                        HTML("); "),
                        HTML("&eta; is overpotential (V); "),
                        HTML(paste("j0 is current density (A/m", tags$sup(2), sep = "")), 
                        HTML("); "),
                        HTML("&alpha; is charge transfer coefficient (-); "),
                        HTML("R is universal gas constant (8.314 J/mol/K); "),
                        HTML("F is Faraday constant (96485 C/mol); "),
                        HTML("n is number of electron involved (fix n=2 for this model); "),
                        HTML("T is temperature (fix T=298K for this model)")
                ), 
                
                em("Note: More information on Butler-Volmer Equation can be found at:"),
                a("http://en.wikipedia.org/wiki/Butler%E2%80%93Volmer_equation"),                 
                
                h3("Result"),
                p("Exchange current density (j0):"),
                verbatimTextOutput("j0out"),
                p(HTML("Charge transfer coefficient (&alpha;):")), 
                verbatimTextOutput("alphaout"),
                
                plotOutput("graph1")
                
        )
))

