# compiles an entire folder of folders

# A short file for quick dat conversion
from knit_script.interpret import knit_script_to_knitout, knit_script_to_knitout_to_dat
from knit_script.knit_graphs.knit_graph_viz import visualize_sheet

from knit_script.knitting_machine.machine_specification.Header_ID import Header_ID
from knit_script.knitting_machine.machine_components.machine_position import Machine_Position

import os;

save_in_usb = True

home = "/Users/izzyyanowitz/knitscript-soft-robots/_my_projects/"


root_folder = "test_files/half_gauge_tubes" # this is the folder that contains your collection of folders
source_dir = home + root_folder
output_dir = home + root_folder
position = Machine_Position.Right

for (root, dirs, files) in os.walk(home + root_folder):
    
    
    
    for file in files:
        
        
        if ".ks" != file[-3:]:
            continue
        
        file_folder = root[len(home + root_folder):]
        title = file[:-3]
        
        print("\n" * 5 + "compiling", title)
        
        if save_in_usb:
            print("saving to usb")
            output_dir = "/Volumes/NO NAME/Student Work/Izzy Yanowitz/" + root_folder + file_folder

        if os.path.isdir(source_dir):
            if not os.path.isdir(output_dir):
                print("making output directory")
                os.makedirs(output_dir)
        else:
            print("source directory does not exist")


        # This outputs a dat file, converts to k first then dat
        knit_graph, _machine_state = knit_script_to_knitout_to_dat(source_dir + file_folder + "/" + title + ".ks", 
                                                                source_dir + file_folder + "/" + title + ".k",
                                                                output_dir + "/" + title + ".dat", 
                                                                pattern_is_filename=True,
                                                                header_values={Header_ID.Position : position})


        # visualize_sheet(knit_graph, source_dir + title + ".png")
        # This generates a visualization .png
