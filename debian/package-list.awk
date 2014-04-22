# generate package list from control file.

BEGIN {
  count = 1
  flag = 0
}

# find all the dependencies, also build dependecies, but stop at the first
# stanza (for example, Descriptions, or Conflicts)
/^(Build-Depends|Depends):/,/^Description:/ {
    if (gsub("^Depends:", "") || gsub("^Build-Depends:","")) { flag = 1 }
    if ($0 !~ /^[ \t]/) { flag = 0 }    # stop at the first stanza
    if (flag == 0) next
    split($0, list, ",");
    for (i in list) {
        if (length(list[i]) > 0) {
            gsub("\(.+\)", "", list[i])
            packages[count] = list[i]
            count += 1
        }
    }
}

END {
    for (i in packages)
	printf("%s ", packages[i])
}
