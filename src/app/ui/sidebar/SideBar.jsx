"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import styles from "./sidebar.module.css";

const navItems = [
  { label: "Inicio", href: "/" },
  { label: "Viajes", href: "/viajes" },
  { label: "Inscripciones", href: "/inscripciones" },
  { label: "Administrador", href: "/admin" },
  { label: "Crear viaje", href: "/admin/crear" },
  { label: "Tu Cuenta ", href: "/cuenta" },
];

export default function Sidebar() {
  const pathname = usePathname();
  const currentYear = new Date().getFullYear();

  return (
    <aside className={styles.sidebar}>
      <h2 className={styles.sidebarTitle}>Gestión de Viajes</h2>
      <nav className={styles.nav}>
        {navItems.map((item) => (
          <Link
            key={item.href}
            href={item.href}
            className={`${styles.navLink} ${
              pathname === item.href ? styles.active : ""
            }`}
          >
            {item.label}
          </Link>
        ))}
      </nav>
      <div className={styles.sidebarFooter}>
        <p>© {currentYear} Viajes Templo</p>
        <p>Desarrollado por Ezequiel Rindello</p>
      </div>
    </aside>
  );
}
