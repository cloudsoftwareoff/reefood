import 'package:flutter/material.dart';
import 'package:reefood/constant/colors.dart';

class ChartRow extends StatelessWidget {
  const ChartRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
    
      mainAxisSize: MainAxisSize.max,
    
      children: [
    
        Expanded(
    
          child: Padding(
    
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
    
            child: Container(
    
              width: 200,
    
              decoration: BoxDecoration(
    
                color: Colors.white,
    
                borderRadius: BorderRadius.circular(8),
    
              ),
    
              child: Padding(
    
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
    
                child: Column(
    
                  mainAxisSize: MainAxisSize.max,
    
                  mainAxisAlignment: MainAxisAlignment.center,
    
                  children: [
    
                    Icon(
    
                      Icons.receipt_rounded,
    
                      color:scheme.primary,
    
                      size: 44,
    
                    ),
    
                    Padding(
    
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 4),
    
                      child: Text(
    
                        '-1',
    
                        textAlign: TextAlign.center,
    
                        style: TextStyle(
    
                              fontFamily: 'Outfit',
    
                              color: Color(0xFF15161E),
    
                              fontSize: 22,
    
                              fontWeight: FontWeight.bold,
    
                            ),
    
                      ),
    
                    ),
    
                    Text(
    
                      'Orders Placed',
    
                      textAlign: TextAlign.center,
    
                      style:
    
                          TextStyle(
    
                                fontFamily: 'Plus Jakarta Sans',
    
                                color: Color(0xFF606A85),
    
                                fontSize: 14,
    
                                fontWeight: FontWeight.w500,
    
                              ),
    
                    ),
    
                  ],
    
                ),
    
              ),
    
            )
    
            // .animateOnPageLoad(
    
            //     animationsMap['containerOnPageLoadAnimation1']!),
    
          ),
    
        ),
    
        Expanded(
    
          child: Padding(
    
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
    
            child: Container(
    
              width: 200,
    
              decoration: BoxDecoration(
    
                color: Colors.white,
    
                borderRadius: BorderRadius.circular(8),
    
              ),
    
              child: Padding(
    
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
    
                child: Column(
    
                  mainAxisSize: MainAxisSize.max,
    
                  mainAxisAlignment: MainAxisAlignment.center,
    
                  children: [
    
                    Icon(
    
                      Icons.attach_money_rounded,
    
                      color:scheme.primary,
    
                      size: 44,
    
                    ),
    
                    Padding(
    
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 4),
    
                      child: Text(
    
                        '\$-1',
    
                        textAlign: TextAlign.center,
    
                        style: TextStyle(
    
                              fontFamily: 'Outfit',
    
                              color: Color(0xFF15161E),
    
                              fontSize: 22,
    
                              fontWeight: FontWeight.bold,
    
                            ),
    
                      ),
    
                    ),
    
                    Text(
    
                      'Money Saved',
    
                      textAlign: TextAlign.center,
    
                      style:
    
                          TextStyle(
    
                                fontFamily: 'Plus Jakarta Sans',
    
                                color: Color(0xFF606A85),
    
                                fontSize: 14,
    
                                fontWeight: FontWeight.w500,
    
                              ),
    
                    ),
    
                  ],
    
                ),
    
              ),
    
            )
    
            // .animateOnPageLoad(
    
            //     animationsMap['containerOnPageLoadAnimation2']!),
    
          ),
    
        ),
    
      ],
    
    );
  }
}