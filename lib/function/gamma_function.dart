import 'dart:math' as math;

final List<double> _gammaDk = [
  2.48574089138753565546e-5,
  1.05142378581721974210,
  -3.45687097222016235469,
  4.51227709466894823700,
  -2.98285225323576655721,
  1.05639711577126713077,
  -1.95428773191645869583e-1,
  1.70970543404441224307e-2,
  -5.71926117404305781283e-4,
  4.63399473359905636708e-6,
  -2.71994908488607703910e-9
];

const int _gammaN = 10;
const double _gammaR = 10.900511;
const double twoSqrtEOverPi = 1.8603827342052657173362492472666631120594218414085755;

double gamma(double z) {
  if (z < 0.5) {
    double s = _gammaDk[0];
    for (int i = 1; i <= _gammaN; i++) {
      s += _gammaDk[i] / (i - z);
    }

    return math.pi / (math.sin(math.pi * z) * s * twoSqrtEOverPi * math.pow((0.5 - z + _gammaR) /  math.e, 0.5 - z));
  } else {
    double s = _gammaDk[0];
    for (int i = 1; i <= _gammaN; i++) {
      s += _gammaDk[i] / (z + i - 1.0);
    }

    return s * twoSqrtEOverPi * math.pow((z - 0.5 + _gammaR) / math.e, z - 0.5);
  }
}