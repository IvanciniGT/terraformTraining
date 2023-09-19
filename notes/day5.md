
     {                                  [
        VARIABLE1 = "value1"                 "VARIABLE1=value1",
        VARIABLE2 = "value2"        =>       "VARIABLE2=value2",
        VARIABLE3 = "value3"                 "VARIABLE3=value3"
      }                                 ]
      
      
     [ for name,value in var.environment: "${name}=${value}" ]
      
      A SET of Strings
      
          for (int i=0; i<10 ; i-- )
          
          for-each (value in LIST)
          
          while(condition){
              
          }
      
  ----
  
  I'm going to create an script. That's my job
  My script ig going to create a bunch of resources... for a reason
  My script is going to define:
    - resources
    - variables (so it could get parameterized)
        - with default values (specified in a .auto.tfvars file)
    - outputs (so it could get integrated with other tools)
  I'm going to leave (release) my script thru a git repository:
    - in my company, so that other partners can use it
    - in github, so that everybody can use it
  
  ---
  
  People are going to use my script to do whatever my script
  does in their own infraestructure.
  
  In order to use my script... they need to provide their custom 
  values for the variables that I have defined.
    That means they need to create their own .tfvars file
  
  ---
  
  Let's say that: 
  I want people to be able to use my script (as it is)
  They are not going to change my script
  - FEATURE: And I want to let them configure the amount of cpus 
    that a resource (container) may use
  - FEATURE2: But I also want lo let then not configure that.
    So that the container has no limits (restrictions) 
