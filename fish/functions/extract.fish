function extract --description "Expand or extract bundled & compressed files" 
    for file in $argv
        if test -f $file
            echo -s "Extracting "(set_color blue)$file(set_color normal)
            switch $file
                case *.tar.bz2   
                    tar xvjf $file    
                case *.tar.gz    
                    tar xvzf $file    
                case *.bz2     
                    bunzip2 $file     
                case *.rar       
                    unrar x $file
                case *.gz        
                    gunzip $file      
                case *.tar       
                    tar xvf $file     
                case *.tbz2      
                    tar xvjf $file    
                case *.tgz       
                    tar xvzf $file    
                case *.zip       
                    unzip $file       
                case *.Z         
                    uncompress $file  
                case *.7z        
                    7z x $file        
                case '*'           
                    echo "don't know how to extract '$file'..."
            end
        else
            echo "'$file' is not a valid file"
        end
    end
end
    
