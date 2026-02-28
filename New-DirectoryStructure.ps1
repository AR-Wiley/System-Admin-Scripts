# Create a base directory and several subdirectories

function dir_structure {

    #Define our directory path

    $dir = "$env:USERPROFILE\Desktop\Directory"

    #Validate that directory path exisits. Create path if one does not exist

    if(!(Test-Path -Path $dir)) {
        Write-Host "Path Does not Exist" -BackgroundColor Red
        Write-Host "Creating Path..." -BackgroundColor Red
            Try{
                New-Item -Path $dir -ItemType Directory
            } Catch {
                Write-Host "Was not able to create path..." -BackgroundColor Red
                Write-Host "An error has occurred: $_" -BackgroundColor Red   
            }
       }


    #Define our sub-directories

    $subDir = @("Documents", "Logs", "Scripts", "Pictures", "Videos")
   
    forEach($i in $subDir){
        Write-Host "Creating Sub-Directory..." -BackgroundColor Blue
        Try{            
            New-Item -Path "$dir\$i" -ItemType Directory    
        } Catch {
            Write-Host "Was not able to create sub-directory..." -BackgroundColor Red
            Write-Host "An error has occurred: $_"  -BackgroundColor Red
        } Finally {
            Write-Host "Subdirectory creation complete" -BackgroundColor Green
        }
    }

}

dir_structure