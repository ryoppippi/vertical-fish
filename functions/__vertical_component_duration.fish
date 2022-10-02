function __vertical_component_duration
  __vertical_util_set VERTICAL_DURATION_COLOR  yellow --bold
  __vertical_util_set VERTICAL_DURATION_MIN    5000
  __vertical_util_set VERTICAL_DURATION_PREFIX ' '
  __vertical_util_set VERTICAL_DURATION_SHOW   true

  if [ $VERTICAL_DURATION_SHOW != true ]
    return
  end

  if [ $CMD_DURATION -lt $VERTICAL_DURATION_MIN ]
    return
  end

  set -l t $CMD_DURATION
  set -l dur
  if [ $t -eq 0 ]
    set dur -a '0s'
  else
    set -l ms (math --scale 0 -- $t % 1000)
    set -l t  (math --scale 0 -- $t / 1000)
    set -l s  (math --scale 0 -- $t % 60)
    set -l t  (math --scale 0 -- $t / 60)
    set -l m  (math --scale 0 -- $t % 60)
    set -l t  (math --scale 0 -- $t / 60)
    set -l h  (math --scale 0 -- $t % 24)
    set -l t  (math --scale 0 -- $t / 24)
    set -l d  $t
    if [ $d != 0 ]
      set -a dur {$d}d
    end
    if [ $h != 0 ]
      set -a dur {$h}h
    end
    if [ $m != 0 ]
      set -a dur {$m}m
    end
    if [ $s != 0 ]
      set -a dur {$s}s
    end
    if [ $ms != 0 ]
      set -a dur {$ms}ms
    end
  end

  echo -ens $VERTICAL_DURATION_PREFIX
  set_color $VERTICAL_DURATION_COLOR
  echo -ens (string join ' ' $dur)
  set_color $VERTICAL_COLOR_NORMAL
end
