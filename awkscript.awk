# BEGIN block: Initialize DXF header and section
BEGIN {
    # faceVertices[0,0]=0
    print "0"
    print "SECTION"
    print "2"
    print "HEADER"
    print "0"
    print "ENDSEC"
    print "0"
    print "SECTION"
    print "2"
    print "TABLES"
    print "0"
    print "ENDSEC"
    print "0"
    print "SECTION"
    print "2"
    print "BLOCKS"
    print "0"
    print "ENDSEC"
    print "0"
    print "SECTION"
    print "2"
    print "ENTITIES"
    print "0"
}

# Process vertex data
/^element vertex/ {
    vertices = $3
}
# Process face data
/^element face/ {
    faces = $3
}
{
    if($1 ~ /^(end_header)$/){
        getline
        for (i = 1; i <= vertices; i++) {
            for (j = 1; j < vertices; j++) {
                vertexList[i,j] = $j
                # print vertexList[i,j]
            }
                getline 
        }
        for(a = 1; a <= faces; a++){
            faceVerticesNum = $1
            for(b = 1; b <= faceVerticesNum; b++){
                faceVertices[a][b] = $(b+1)
                print faceVertices[a][b]
            }       
        getline
        }





    }
}

END{
        # for(k = 1; k <= faces; k++){
        #     faceVertices[k] = vertexList[i];

        # }
    
    for(i = 1; i <= vertices; i++){
        print "VERTEX"
        print "8"
        print "0"
        print "10"
        print vertexList[i,1]
        print "20"
        print vertexList[i,2]
        print "30"
        print vertexList[i,3]
        print "0"
    }
    for (i = 1; i <= faces; i++) {
        print "FACE"
        # getline
        # split($0, indices)

        print "0"
        print "8"
        print "0"  # Layer name

        for(j = 1; j <= faceVerticesNum; j++){

            l = 1
            print j + "9"
            print vertexList[faceVertices[i][j]+1,l]  # X coordinate of vertex 1
            l++
            print j + "19"
            print vertexList[faceVertices[i][j]+1,l]  # Y coordinate of vertex 1
            print j + "29"
            l++
            print vertexList[faceVertices[i][j]+1,l]  # Z coordinate of vertex 1
        }
            print "0"  # End of LINE entity
    }
}

# END block: Close DXF sections
END {
    print "ENDSEC"
    print "0"
    print "EOF"
}