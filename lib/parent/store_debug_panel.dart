import 'package:flutter/material.dart';

import '../services/entitlement_service.dart';
import '../store/catalog.dart';
import '../store/store_service.dart';
import '../ui/app_font.dart';
import '../ui/l10n.dart';

/// Ladicí sekce rodičovského koutku (jen `kDebugMode`): simulace zapnutého
/// obchodu a nákupů přes [FakeStore]. Skutečná záložka „Další ostrovy"
/// přijde ve fázi 2 (`docs/MONETIZATION.md` §7).
class StoreDebugPanel extends StatefulWidget {
  const StoreDebugPanel({super.key});

  @override
  State<StoreDebugPanel> createState() => _StoreDebugPanelState();
}

class _StoreDebugPanelState extends State<StoreDebugPanel> {
  Map<String, String> _prices = const {};

  @override
  void initState() {
    super.initState();
    _loadPrices();
  }

  Future<void> _loadPrices() async {
    final service = EntitlementService.instance;
    final offers = await service.store
        .loadProducts({for (final p in service.catalog.products) p.id});
    if (mounted) {
      setState(() => _prices = {for (final o in offers) o.id: o.price});
    }
  }

  TextStyle _style(double size, double alpha, [FontWeight? weight]) => TextStyle(
        fontFamily: kFont,
        fontFamilyFallback: kFontFallback,
        fontSize: size,
        fontWeight: weight ?? FontWeight.w700,
        color: Colors.white.withValues(alpha: alpha),
      );

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: EntitlementService.instance,
      builder: (context, _) {
        final service = EntitlementService.instance;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              key: const ValueKey('store-debug-toggle'),
              value: service.debugEnabled,
              onChanged: (v) => service.debugEnabled = v,
              activeThumbColor: const Color(0xFFFFD200),
              contentPadding: EdgeInsets.zero,
              title: Text(context.l.storeDebugEnable,
                  style: _style(15, 1, FontWeight.w800)),
            ),
            if (service.debugEnabled) ...[
              for (final product in service.catalog.products)
                _row(context, service, product),
              Wrap(
                spacing: 8,
                children: [
                  TextButton(
                    key: const ValueKey('store-restore'),
                    onPressed: service.restore,
                    child: Text(context.l.storeRestore),
                  ),
                  TextButton(
                    key: const ValueKey('store-debug-forget'),
                    onPressed: service.debugForgetPurchases,
                    child: Text(context.l.storeDebugForget),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _row(BuildContext context, EntitlementService service,
      CatalogProduct product) {
    final owned = service.owns(product.id);
    final price = _prices[product.id];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title(context.l),
                    style: _style(14, 0.9, FontWeight.w800)),
                Text(product.description(context.l), style: _style(12, 0.55)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (owned)
            Text(context.l.storeStateOwned,
                key: ValueKey('store-owned-${product.id}'),
                style: _style(13, 0.7))
          else if (service.redundant(product))
            Text(context.l.storeStateFree,
                key: ValueKey('store-free-${product.id}'),
                style: _style(13, 0.7))
          else
            TextButton(
              key: ValueKey('store-buy-${product.id}'),
              onPressed:
                  price == null ? null : () => service.buy(product.id),
              child: Text(price == null ? '…' : context.l.storeBuy(price)),
            ),
        ],
      ),
    );
  }
}
