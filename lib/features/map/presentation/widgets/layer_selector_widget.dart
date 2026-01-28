import 'package:flutter/material.dart';

enum MapLayerType { normal, satellite, terrain }

class LayerSelectorWidget extends StatelessWidget {
  final MapLayerType currentLayer;
  final Function(MapLayerType) onLayerChanged;

  const LayerSelectorWidget({
    super.key,
    required this.currentLayer,
    required this.onLayerChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MapLayerType>(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(Icons.layers, color: Theme.of(context).colorScheme.primary),
      ),
      onSelected: onLayerChanged,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MapLayerType>>[
        const PopupMenuItem<MapLayerType>(
          value: MapLayerType.normal,
          child: Row(
            children: [
              Icon(Icons.map_outlined),
              SizedBox(width: 8),
              Text('Default (OSM)'),
            ],
          ),
        ),
        const PopupMenuItem<MapLayerType>(
          value: MapLayerType.satellite,
          child: Row(
            children: [
              Icon(Icons.satellite_alt),
              SizedBox(width: 8),
              Text('Satellite (Esri)'),
            ],
          ),
        ),
        const PopupMenuItem<MapLayerType>(
          value: MapLayerType.terrain,
          child: Row(
            children: [
              Icon(Icons.terrain),
              SizedBox(width: 8),
              Text('Terrain (Topo)'),
            ],
          ),
        ),
      ],
    );
  }
}
