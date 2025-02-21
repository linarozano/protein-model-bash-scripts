# based on a script found at pastebin.com/5mkwWJdd,
# which is in turn based on my script list_hbonds.py
# Copyright (c) 2010 Robert L. Campbell
from pymol import cmd
from pymol import stored

def list_hb(selection, selection2=None, cutoff=3.2,
        angle=45, mode=1, hb_list_name='hbonds',print_distances=1,write_distances_file=None):
  """
  USAGE

  list_hb selection, [selection2 (default=None)], [cutoff (default=3.2)],
                     [angle (default=45)], [mode (default=1)],
                     [hb_list_name (default='hbonds')], [print_distances (default=1)]
                     [write_distances (default=None)]

  The script automatically adds a requirement that atoms in the
  selection (and selection2 if used) must be either of the elements N or
  O.

  If mode is set to 0 instead of the default value 1, then no angle
  cutoff is used, otherwise the angle cutoff is used and defaults to 45
  degrees.

  e.g.
  To get a list of all H-bonds within chain A of an object and to save it to a file
    list_hb 1abc & c. a &! r. hoh, cutoff=3.2, hb_list_name=abc-hbonds,write_distances_file=abc-hbonds.dat

  To get a list of H-bonds between chain B and everything else:
    list_hb 1tl9 & c. b, 1tl9 &! c. b
  """

  if write_distances_file:
    hb_data = open(write_distances_file, 'w')

  cutoff = float(cutoff)
  angle = float(angle)
  mode = int(mode)
  print_distances=int(print_distances)
  # ensure only N and O atoms are in the selection
  selection = selection + " & e. n+o"
  if not selection2:
      hb = cmd.find_pairs(selection, selection, mode=mode,
              cutoff=cutoff, angle=angle)
  else:
      selection2 = selection2 + " & e. n+o"
      hb = cmd.find_pairs(selection, selection2, mode=mode,
              cutoff=cutoff, angle=angle)


# convert hb list to set to remove duplicates
  hb_set = set()
  for atoms in hb:
    a = [atoms[0],atoms[1]]
    a.sort()
    hb_set.add(tuple(a))

# convert set back to list and sort for easier reading
  hb = list(hb_set)
  hb.sort(key=lambda x: x[0][1])

  stored.listA = []
  stored.listB = []
  stored.listC = []

  for pairs in hb:
    cmd.iterate("%s and index %s" % (pairs[0][0], pairs[0][1]),
            'stored.listA.append( "%1s/%3s`%s/%s/%i " % (chain, resn, resi, name, ID),)')

    cmd.iterate("%s and index %s" % (pairs[1][0], pairs[1][1]),
            'stored.listB.append( "%1s/%3s`%s/%s/%i " % (chain, resn, resi, name, ID),)')

    stored.listC.append(cmd.distance(hb_list_name, "%s and index %s" %
                (pairs[0][0], pairs[0][1]), "%s and index %s" % (pairs[1][0],
                    pairs[1][1])))

  for line in enumerate(stored.listA):
    if print_distances:
      print("%s   %s   %.2f" % (stored.listA[line[0]], stored.listB[line[0]], stored.listC[line[0]]))
    if write_distances_file:
      hb_data.write("%s   %s   %.2f\n" % (stored.listA[line[0]], stored.listB[line[0]], stored.listC[line[0]]))
  if write_distances_file:
    hb_data.close()

  return stored.listA, stored.listB, stored.listC

cmd.extend("list_hb", list_hb)