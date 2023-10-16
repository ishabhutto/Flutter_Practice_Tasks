import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      theme: ThemeData(
        primaryColor: Colors.pink,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position? _currentPosition;
  String? _currentAddress;
  DateTime? _lastUpdatedTime;
  bool _isLoading = false;
  bool showCity = true;
  bool showState = true;
  bool showCountry = true;

  List<String> addressHistory = [];

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enable Location Service in device settings."),
      ));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Location Permission Denied!"),
        ));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Location Permission Denied! Go to your app settings."),
      ));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    final bool hasPermission = await _handlePermission();
    if (!hasPermission) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
        _lastUpdatedTime = DateTime.now();
        _isLoading = false;
      });
      getAddressFromCoordinates(_currentPosition!);
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  Future<void> getAddressFromCoordinates(Position position) async {
    try {
      final List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      final Placemark place = placemarks[0];
      final address = getAddressString(place);
      setState(() {
        _currentAddress = address;
        addressHistory.insert(0, address);
      });
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  String getAddressString(Placemark place) {
    String address = '';
    if (showCity) {
      address += '${place.locality}, ';
    }
    if (showState) {
      address += '${place.administrativeArea}, ';
    }
    if (showCountry) {
      address += place.country!;
    }
    return address;
  }

  void clearAddressHistory() {
    setState(() {
      addressHistory.clear();
    });
  }

  void shareAddress() {
    if (_currentAddress != null) {
      final String address = _currentAddress!;
      Clipboard.setData(ClipboardData(text: address));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Address copied to clipboard"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Location and Address'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_isLoading)
                const CircularProgressIndicator()
              else
                Text('LAT: ${_currentPosition?.latitude ?? ""}'),
              if (_isLoading)
                const SizedBox(height: 16)
              else
                Text('LNG: ${_currentPosition?.longitude ?? ""}'),
              if (_lastUpdatedTime != null)
                Text('Last Updated: $_lastUpdatedTime'),
              if (_currentAddress != null) Text('ADDRESS: ${_currentAddress}'),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Show City: '),
                  Switch(
                    value: showCity,
                    onChanged: (bool value) {
                      setState(() {
                        showCity = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Show State: '),
                  Switch(
                    value: showState,
                    onChanged: (bool value) {
                      setState(() {
                        showState = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Show Country: '),
                  Switch(
                    value: showCountry,
                    onChanged: (bool value) {
                      setState(() {
                        showCountry = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _getCurrentLocation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                ),
                child: const Text('Get Location'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: shareAddress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                ),
                child: const Text('Share Address'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Address History:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: addressHistory.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(addressHistory[index]),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: clearAddressHistory,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink, 
                ),
                child: const Text('Clear History'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
