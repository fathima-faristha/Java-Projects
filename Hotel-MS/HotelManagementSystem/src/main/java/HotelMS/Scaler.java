/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Jrff
 */
package HotelMS;

import java.awt.*;
import java.awt.event.*;
import javax.swing.JPanel;

public class Scaler {
    public static void make(Container c) {
        final Dimension base = c.getSize();
        final Component[] kids = c.getComponents();
        final Rectangle[] orig = new Rectangle[kids.length];
        for (int i = 0; i < kids.length; i++) orig[i] = kids[i].getBounds();

        c.setLayout(null);
        for (Component k : kids) {
            if (k instanceof JPanel) make((Container) k);
        }
        if (base.width == 0 || base.height == 0) return;

        c.addComponentListener(new ComponentAdapter() {
            @Override
            public void componentResized(ComponentEvent e) {
                double sx = (double) c.getWidth() / base.width;
                double sy = (double) c.getHeight() / base.height;
                for (int i = 0; i < kids.length; i++) {
                    Rectangle r = orig[i];
                    kids[i].setBounds((int) (r.x * sx), (int) (r.y * sy),
                                      (int) (r.width * sx), (int) (r.height * sy));
                }
            }
        });
    }
}
