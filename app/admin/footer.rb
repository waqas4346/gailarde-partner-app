module ActiveAdmin
    module Views
      class Footer < Component
  
        def build(namespace)
          super :id => "footer"                                                    
          super :style => "text-align: right;"                                     
  
          div do                                                                   
            small ""                                       
          end
        end
  
      end
    end
  end