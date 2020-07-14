session="work"

# set up tmux
tmux start-server

#==============================================================================
# create a new tmux session, starting mc from a saved session in the new window
tmux new-session -d -s $session -n "mnemo"
tmux selectp -t 1
tmux send-keys "cd home_workspace/docker-dev" C-m
tmux send-keys "reset" C-m
tmux splitw -v -p 25
tmux selectp -t 2
tmux send-keys "cd ~/workspace/mnemo_php" C-m
tmux send-keys "tmux swap-pane -U " C-m
tmux send-keys "reset" C-m
tmux send-keys "./getLast.sh " C-m

#==============================================================================
# Select pane 1 run cm
tmux new-window -t $session:1 -n "mc&toolbox"
tmux selectp -t 1
tmux send-keys "cd ~/workspace" C-m
tmux send-keys "mc" C-m
#------------------------------------------------------------------------------
# Split pane 1 horizontal by 65%, start redis-server
tmux splitw -v -p 35
tmux send-keys "cd ~/workspace/oht" C-m
tmux send-keys "toolbox up" C-m
#tmux send-keys "reset" C-m
#------------------------------------------------------------------------------
# Select pane 2
tmux selectp -t 2
tmux splitw -h -p 75
tmux send-keys "cal" C-m

#==============================================================================

# create a new window called workspace
tmux new-window -t $session:2 -n workspace
tmux selectp -t 1
tmux send-keys "cd ~/workspace/oht" C-m
tmux send-keys "reset" C-m

# Split pane 1 horizontal by 65%, start redis-server
tmux splitw -v -p 35
tmux selectp -t 2
tmux send-keys "~" C-m
tmux send-keys "reset" C-m
#tmux send-keys "docker ps" C-m

# return to main mc window
tmux select-window -t $session:0

# Finished setup, attach to the tmux session!
tmux -2 attach-session -t $session