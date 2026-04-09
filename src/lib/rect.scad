module rect_r(
    width=12
  , depth=6
  , xyr = 3
) {
  xyr = min(xyr, depth / 2, width / 2);
  union() {
    if (depth > 2 * xyr)
      square([width, depth - 2 * xyr], center=true);
    if (width > 2 * xyr)
      square([width - 2 * xyr, depth], center=true);
    for (cxy = [[-1, -1], [-1, 1], [1, -1], [1, 1]])
      translate([cxy[0] * (width / 2 - xyr), cxy[1] * (depth / 2 - xyr)])
        circle(xyr);
  }
}

module diamond_r(a=5, b=8, r=2) {
  x = (a > r * 2 && b > r * 2)? (a - r * 2) : a;
  y = (a > r * 2 && b > r * 2)? (b - r * 2) : b;
  r0 = (a > r * 2 && b > r * 2)? r: 0;

  if(a <= r * 2 || b <= r * 2) {
    echo("try smaller r in calling diamond_r");
  }

  offset(r=r0)
    polygon([[x, 0], [0, y], [-x, 0], [0, -y], [x, 0]]);
}
